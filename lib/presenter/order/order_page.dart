import 'package:dtk_store/core/utils/get_time_range.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/client_coords_picker_map.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/address/second_map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '/presenter/order/cubit/order_cubit.dart';
import '/presenter/order/modal_sheet/edit_address_modal.dart';

import 'modal_sheet/cubit/modal_sheet_cubit.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is AirstrikeSendSuccessState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Un operador se pondrá en contacto con usted en breve'),
              backgroundColor: Colors.green.shade400,
              behavior: SnackBarBehavior.floating,
              padding: const EdgeInsets.all(8.0),
              duration: const Duration(seconds: 6),
            ),
          );
        }
        if (state is AirstrikeSendFailureState) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Error, inténtelo de nuevo más tarde'),
              backgroundColor: Colors.red.shade400,
              behavior: SnackBarBehavior.floating,
              padding: const EdgeInsets.all(8.0),
              duration: const Duration(seconds: 6),
            ),
          );
        }
      },
      buildWhen: (context, state) {
        if (state is OrderLoadSuccessState || state is OrderLoadingState) {
          return true;
        } else {
          return false;
        }
      },
      builder: (context, state) {
        if (state is OrderLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrderLoadFailedState) {
          //TODO: Сделать виджет ошибки
          return Container();
        }

        if (state is OrderLoadSuccessState) {
          return OrderPageBody(
            order: state.order,
            isConfirmed: state.isConfirmed,
            isAirstrikeLoading: state.isAirstrikeLoading,
          );
        } else {
          //TODO: Сделать виджет ошибки
          return Container();
        }
      },
    );
  }
}

class OrderPageBody extends StatefulWidget {
  const OrderPageBody({
    Key? key,
    required this.order,
    required this.isConfirmed,
    required this.isAirstrikeLoading,
  }) : super(key: key);

  final Order order;
  final bool isConfirmed;
  final bool isAirstrikeLoading;

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
  Location location = Location();

  final ScrollController _positionsScrollContorller = ScrollController();

  final Map productImagePath = {
    'Alpha Man': 'assets/images/Alphaman_small.png',
    'Bioprost': 'assets/images/Bioprost_bottle_big.png',
    'Cardiox': 'assets/images/Cardiox_bottle_big.png',
    'Flexacil': 'assets/images/Flexacil_es2.png',
    'Glyconorm': 'assets/images/Glyconorm_bottle_small.png',
    'Turboslim': 'assets/images/Turboslim_20.png',
    'Gialuron Revita': 'assets/images/Placeholder.png',
  };
  late LatLng coords;
  bool _isMapVisible = true;
  String _currentTimeRange = '';
  late Order _newOrder;
  late Order _currentOrder;

  @override
  void initState() {
    super.initState();
    // _serviceEnabled = false;
    _currentOrder = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Todo(Жандос) вынести в виджет Cart
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'TU PEDIDO #${_currentOrder.shortCode}',
                              style: const TextStyle(
                                fontSize: 32,
                                color: Color(0XFF557EF1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            widget.isConfirmed == true
                                ? const Text(
                                    'la entrega del pedido!',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Container(),
                            const Divider(),
                            Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                ..._currentOrder.positions.asMap().entries.map(
                                  (item) {
                                    int itemIndex = item.key;
                                    String productName = item.value.product.name.toUpperCase();
                                    return Text(
                                      '$productName${itemIndex == _currentOrder.positions.length - 1 ? '' : ' + '}',
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: Color(0XFF557EF1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'PRECIO REGULAR',
                                style: GoogleFonts.oswald(
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${(_currentOrder.totalCents * 2.8).round()}/s',
                                style: GoogleFonts.oswald(
                                  height: 1.1,
                                  fontSize: 52,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'PRECIO PARA TI',
                                style: GoogleFonts.oswald(
                                  fontSize: 18,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${_currentOrder.totalCents.round()}/s',
                                style: GoogleFonts.oswald(
                                  height: 1.1,
                                  fontSize: 52,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          SizedBox(
                            width: 480,
                            height: 220,
                            child: ScrollConfiguration(
                              behavior: PositionsScrollBehavior(),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                clipBehavior: Clip.none,
                                controller: _positionsScrollContorller,
                                physics: const PageScrollPhysics(),
                                children: [
                                  ..._currentOrder.positions
                                      .map(
                                        (items) => Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Image.asset(
                                              productImagePath[items.product.name],
                                              width: 145,
                                              height: 240,
                                            ),
                                            Positioned(
                                              top: -10,
                                              left: 15,
                                              child: CircleAvatar(
                                                radius: 20,
                                                child: Text(
                                                  'x${items.quantity}',
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                backgroundColor: const Color(0xFF73B488),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ],
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: -30,
                          //   child: PromoBox(),
                          // )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12), //TODO:(Жандос) Вернуть 40 когда вернем PromoBox
                //Todo(Жандос) вынести в виджет Contact
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Nombre: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _currentOrder.client.fullname,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Distrito: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _currentOrder.client.address.district,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Province: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _currentOrder.client.address.city,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Direccion: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _currentOrder.client.address.street,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Referencia: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: _currentOrder.client.address.country,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Fecha prevista',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (_currentOrder.plannedDate != null)
                                  ? Text(
                                      '${DateFormat.MMMMd().format(_currentOrder.plannedDate!)} ${_currentOrder.plannedDate == DateTime.now() ? '(Hoy)' : ''}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : const Text('Por favor, confirme'),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Tiempo previsto',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (_currentOrder.plannedDate != null)
                                  ? Text(
                                      getTimeRange(
                                        _currentOrder.plannedDate!,
                                        _currentOrder.plannedDateDuration!,
                                        ' - ',
                                      ),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : const Text('Por favor, confirme'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //Todo(Жандос) вынести в виджет ContactButton
                Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: widget.isConfirmed == false
                            ? ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => BlocProvider<ModalSheetCubit>(
                                      create: (context) => ModalSheetCubit(),
                                      child: EditAddressModalBottomSheet(
                                        order: _currentOrder,
                                        orderCubit: BlocProvider.of<OrderCubit>(context),
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'EDITAR LA DIRECCION',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(MediaQuery.of(context).size.width, 60),
                                  primary: Colors.white,
                                  onPrimary: const Color(0XFF557EF1),
                                  side: const BorderSide(color: Color(0XFF557EF1)),
                                ),
                              )
                            : Container(),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
                //Todo(Жандос) вынести в виджет MapWrapper
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      widget.isConfirmed == true
                          // Заголовок карты Отслеживания
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'TU PEDIDO ESTA\nEN CAMINO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  getTimeRange(_currentOrder.plannedDate!,
                                      _currentOrder.plannedDateDuration!),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          // Заголовок карты Выбора координаты клиента
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.arrow_downward),
                                Text(
                                  'POR FAVOR AYUDANOS A ENCONTRAR\nTU UBICACION EXACTA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_downward),
                              ],
                            ),
                      const SizedBox(height: 12),

                      SizedBox(
                        width: 480,
                        height: 400,
                        child: Center(
                          //Скрываем карту когда открыто меню выбора времени,
                          //Так как у карты всегда самый высокий Z-index
                          child: Visibility(
                            visible: _isMapVisible,
                            child: widget.isConfirmed
                                ? SecondMapWidget(order: widget.order)
                                : ClientCoordsPickerMap(
                                    order: widget.order,
                                    orderCubit: BlocProvider.of<OrderCubit>(context),
                                    onCoordsChange: (newCoords) => coords = newCoords,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      //todo Жанодос Структура неудобная.. Но надо подумать стоит ли!!!
                      // Видишь везде куски отдельные проверяют подтвержден или нет заказ [isConfirmed].
                      // Лучше вынести проверку эту как можно выше и сделать 2 больших виджета:
                      // ПодтверждениеКоординатыКлиента
                      // ОтслеживаниеКурьера
                      widget.isConfirmed == false
                          ? Card(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Icon(Icons.arrow_downward),
                                        Text(
                                          'POR FAVOR, ELIJA UNA HORA\nDE ENTREGA CONVENIENTE',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(Icons.arrow_downward),
                                      ],
                                    ),
                                    //TODO: (Жандос) сделать текст через getRangeTime после добавления функционала кнопки
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 24),
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _currentTimeRange == ''
                                                  ? '${DateFormat.Hm().format(_currentOrder.plannedDate!)} - ${DateFormat.Hm().format(_currentOrder.plannedDate!.add(Duration(minutes: 90)))}'
                                                  : _currentTimeRange,
                                              style: const TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.w600),
                                            ),
                                            const Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(120, 50),
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          primary: Colors.white,
                                          onPrimary: const Color(0XFF557EF1),
                                          side: const BorderSide(color: Color(0XFF557EF1)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isMapVisible = false;
                                          });
                                          showCupertinoModalPopup(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) => CupertinoActionSheet(
                                              actions: <Widget>[
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text('08:30 - 10:00'),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '08:30 - 10:00',
                                                        90,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '09:00 - 11:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '09:00 - 11:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '10:00 - 12:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '10:00 - 12:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '11:00 - 13:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '11:00 - 13:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '12:00 - 14:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '12:00 - 14:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '13:00 - 15:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '13:00 - 15:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '14:00 - 16:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '14:00 - 16:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '15:00 - 17:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '15:00 - 17:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '16:00 - 18:00',
                                                    ),
                                                    onPressed: () {
                                                      _onPressedCupertinoActionTimeItem(
                                                        '16:00 - 18:00',
                                                        120,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                              cancelButton: CupertinoActionSheetAction(
                                                child: const Text('Cancel'),
                                                isDefaultAction: true,
                                                onPressed: () {
                                                  setState(() {
                                                    _isMapVisible = true;
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    //* Кнопка подтверждения координаты и времени
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_newOrder != null) {
                                          BlocProvider.of<OrderCubit>(context)
                                              .updateOrder(_newOrder);
                                          BlocProvider.of<AddressCubit>(context).updateCoords(
                                              coords,
                                              _newOrder.client.address.id,
                                              _newOrder.shortCode,
                                              _newOrder.client.phone);
                                        } else {
                                          BlocProvider.of<OrderCubit>(context)
                                              .updateOrder(_currentOrder);
                                          BlocProvider.of<AddressCubit>(context).updateCoords(
                                              coords,
                                              _currentOrder.client.address.id,
                                              _currentOrder.shortCode,
                                              _currentOrder.client.phone);
                                        }
                                      },
                                      child: const Text(
                                        'POR FAVOR, CONFIRME LA HORA DE ENTREGA Y LA DIRECCIÓN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(16),
                                        primary: const Color(0XFF67C99C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: widget.isConfirmed == false
                            ? const EdgeInsets.fromLTRB(12, 96, 12, 48)
                            : const EdgeInsets.fromLTRB(12, 36, 12, 48),
                        //* Кнопка запроса поддержки
                        child: ElevatedButton(
                          onPressed: widget.isAirstrikeLoading
                              ? () {}
                              : () {
                                  showDialog<void>(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Solicitar asistencia'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: const <Widget>[
                                              Text(
                                                  '¿Seguro que quieres contactar con el operador?'),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Sí'),
                                            onPressed: () {
                                              //TODO: добавить progress indicator пока идет отправка, добавить таймер для дизейблд кнопки
                                              BlocProvider.of<OrderCubit>(context)
                                                  .createNotification(
                                                shortCode: _currentOrder.shortCode,
                                                phone: _currentOrder.client.phone,
                                                order: _currentOrder,
                                                isConfirmed: widget.isConfirmed,
                                              );
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: const Text('No'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                          child: widget.isAirstrikeLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'LLAMA A MI  ACCESOR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                            primary: const Color(0XFF557EF1),
                            onPrimary: Colors.white,
                            side: const BorderSide(
                              width: 1,
                              color: Color(0XFF557EF1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedCupertinoActionTimeItem(
    String timeRange,
    int plannedDateDuration,
  ) {
    String fromTime = timeRange.split(' - ')[0];
    return setState(() {
      _isMapVisible = true;
      _currentTimeRange = timeRange;
      String _formatedDate = DateFormat('yyyy-M-dd').format(
        _currentOrder.plannedDate!,
      );
      DateTime _selectedTime = DateTime.parse('$_formatedDate ${fromTime}Z');
      _newOrder = _currentOrder.copyWith(
        plannedDate: _selectedTime,
        plannedDateDuration: plannedDateDuration,
      );
    });
  }
}

//Без этого класса не работал скролл в ListView
class PositionsScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
