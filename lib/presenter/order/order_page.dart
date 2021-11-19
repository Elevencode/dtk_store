import 'package:dtk_store/core/static/product_image_path.dart';
import 'package:dtk_store/core/utils/get_time_range.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/address/client_coords_picker_map.dart';
import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/address/second_map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '/presenter/order/cubit/order_cubit.dart';
import '/presenter/order/modal_sheet/edit_address_modal.dart';

import 'modal_sheet/cubit/modal_sheet_cubit.dart';
import 'widgets/cart.dart';
import 'widgets/contact.dart';

const timeRanges = [
  ['08:30', '10:00'],
  ['09:00', '11:00'],
  ['10:00', '12:00'],
  ['11:00', '13:00'],
  ['12:00', '14:00'],
  ['13:00', '15:00'],
  ['14:00', '16:00'],
  ['15:00', '17:00'],
  ['16:00', '18:00'],
];

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
              content: const Text(
                  'Un operador se pondrá en contacto con usted en breve'),
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
  State<OrderPageBody> createState() => OrderPageBodyState();
}

class OrderPageBodyState extends State<OrderPageBody> {
  late LatLng coords;
  String _currentTimeRange = '';
  late Order _currentOrder;

  @override
  void initState() {
    super.initState();
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
                Cart(
                  order: _currentOrder,
                  isConfirmed: widget.isConfirmed,
                  productImagePath: productImagePath,
                ),
                const SizedBox(height: 12),
                Contact(order: _currentOrder),
                //Todo(Жандос) вынести в виджет ContactButton
                Container(
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8.0),
                        child: !widget.isConfirmed
                            ? ElevatedButton(
                                onPressed: () => _showEditAddressPopup(),
                                child: const Text(
                                  'EDITAR LA DIRECCION',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 60),
                                  primary: Colors.white,
                                  onPrimary: const Color(0XFF557EF1),
                                  side: const BorderSide(
                                      color: Color(0XFF557EF1)),
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
                      widget.isConfirmed
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
                                  getTimeRange(
                                    _currentOrder.plannedDate!,
                                    _currentOrder.plannedDateDuration!,
                                  ),
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
                          child: widget.isConfirmed
                              ? SecondMapWidget(
                                  order: widget.order,
                                )
                              : ClientCoordsPickerMap(
                                  order: widget.order,
                                  orderCubit:
                                      BlocProvider.of<OrderCubit>(context),
                                  onCoordsChange: (newCoords) =>
                                      coords = newCoords,
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      //todo Жанодос Структура неудобная.. Но надо подумать стоит ли!!!
                      // Видишь везде куски отдельные проверяют подтвержден или нет заказ [isConfirmed].
                      // Лучше вынести проверку эту как можно выше и сделать 2 больших виджета:
                      // ПодтверждениеКоординатыКлиента
                      // ОтслеживаниеКурьера
                      !widget.isConfirmed
                          ? Card(
                              margin: EdgeInsets.zero,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 8),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _currentTimeRange == ''
                                                  ? '${DateFormat.Hm().format(_currentOrder.plannedDate!)} - ${DateFormat.Hm().format(_currentOrder.plannedDate!.add(const Duration(minutes: 90)))}'
                                                  : _currentTimeRange,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(120, 50),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          primary: Colors.white,
                                          onPrimary: const Color(0XFF557EF1),
                                          side: const BorderSide(
                                              color: Color(0XFF557EF1)),
                                        ),
                                        onPressed: () => _showTimeRangesPopup(),
                                      ),
                                    ),

                                    //* Кнопка подтверждения координаты и времени
                                    ElevatedButton(
                                      onPressed: () =>
                                          _showCoordsAndTimeConfirmationDialog(),
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
                        padding: !widget.isConfirmed
                            ? const EdgeInsets.fromLTRB(12, 96, 12, 48)
                            : const EdgeInsets.fromLTRB(12, 36, 12, 48),
                        //* Кнопка запроса поддержки
                        child: ElevatedButton(
                          onPressed: widget.isAirstrikeLoading
                              ? null
                              : () => _showAirstrikeConfirmationDialog(),
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
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 20, 50),
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

  Future<dynamic> _showEditAddressPopup() {
    return showModalBottomSheet(
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
  }

  Future<dynamic> _showTimeRangesPopup() {
    return showCupertinoModalPopup(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: timeRanges.map((range) {
          var value = range.join(" - ");

          return Container(
            color: Colors.white,
            child: CupertinoActionSheetAction(
              child: Text(value),
              onPressed: () {
                _onPressedCupertinoActionTimeItem(
                  value,
                  90,
                );
                Navigator.pop(context);
              },
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Future<void> _showAirstrikeConfirmationDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solicitar asistencia'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Seguro que quieres contactar con el operador?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Sí'),
              onPressed: () {
                //TODO: добавить progress indicator пока идет отправка, добавить таймер для дизейблд кнопки
                BlocProvider.of<OrderCubit>(context).createNotification(
                  shortCode: _currentOrder.shortCode,
                  phone: _currentOrder.client.phone,
                  order: _currentOrder,
                  isConfirmed: widget.isConfirmed,
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showCoordsAndTimeConfirmationDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación de datos'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Está seguro de que desea verificar los datos?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Sí'),
              onPressed: () {
                //TODO: Добавить progress indicator пока идет отправка, добавить таймер для дизейблд кнопки
                BlocProvider.of<OrderCubit>(context).updateOrder(
                  _currentOrder.copyWith(
                    client: _currentOrder.client.copyWith(
                      address: _currentOrder.client.address.copyWith(
                        lat: coords.latitude,
                        lng: coords.longitude,
                      ),
                    ),
                  ),
                );
                BlocProvider.of<AddressCubit>(context).updateCoords(
                  coords,
                  _currentOrder.client.address.id,
                  _currentOrder.shortCode,
                  _currentOrder.client.phone,
                );

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onPressedCupertinoActionTimeItem(
    String timeRange,
    int plannedDateDuration,
  ) {
    String fromTime = timeRange.split(' - ')[0];

    setState(() {
      _currentTimeRange = timeRange;
      String _formatedDate = DateFormat('yyyy-M-dd').format(
        _currentOrder.plannedDate!,
      );
      DateTime _selectedTime = DateTime.parse('$_formatedDate ${fromTime}Z');
      _currentOrder = _currentOrder.copyWith(
        plannedDate: _selectedTime,
        plannedDateDuration: plannedDateDuration,
      );
    });
  }
}
