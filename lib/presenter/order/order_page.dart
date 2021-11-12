import 'package:dtk_store/presenter/address/cubit/map_widget_cubit.dart';
import 'package:dtk_store/presenter/address/map_widget.dart';
import 'package:dtk_store/presenter/address/second_map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '/model/order.dart';
// import '../address/client_coords_picker_map.dart';
import '/presenter/order/cubit/order_cubit.dart';
import '/presenter/order/modal_sheet/edit_address_modal.dart';

import 'modal_sheet/cubit/modal_sheet_cubit.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
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
  }) : super(key: key);

  final Order order;
  final bool isConfirmed;

  @override
  State<OrderPageBody> createState() => _OrderPageBodyState();
}

class _OrderPageBodyState extends State<OrderPageBody> {
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
  String _currentTime = '';
  Order? _order;

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
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'YOUR ORDER #${widget.order.shortCode}',
                              style: const TextStyle(
                                fontSize: 32,
                                color: Color(0XFF557EF1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            widget.isConfirmed == true
                                ? const Text(
                                    'заказ доставляется!',
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
                                ...widget.order.positions.asMap().entries.map(
                                  (item) {
                                    int itemIndex = item.key;
                                    String productName =
                                        item.value.product.name;
                                    return Text(
                                      '$productName${itemIndex == widget.order.positions.length - 1 ? '' : ' + '}',
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
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'PRECIO',
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'REGULAR',
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${(widget.order.totalCents * 2.8).round()}/s',
                                  style: GoogleFonts.oswald(
                                    fontSize: 48,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'PRECIO',
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'PARA TI',
                                      style: GoogleFonts.oswald(
                                        fontSize: 18,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${widget.order.totalCents.round()}/s',
                                  style: GoogleFonts.oswald(
                                    fontSize: 48,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                                  ...widget.order.positions
                                      .map(
                                        (items) => Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Image.asset(
                                              productImagePath[
                                                  items.product.name],
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
                                                backgroundColor:
                                                    const Color(0xFF73B488),
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
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Name: ',
                              style: TextStyle(
                                height: 1.41,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: widget.order.client.fullname,
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
                              text: widget.order.client.address.district,
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
                              text: widget.order.client.address.city,
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
                              text: widget.order.client.address.street,
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
                              text: widget.order.client.address.country,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Planned date',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (widget.order.plannedDate != null)
                                  ? Text(
                                      '${DateFormat.MMMMd().format(widget.order.plannedDate!)} ${widget.order.plannedDate == DateTime.now() ? '(Today)' : ''}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : const Text('Please confirmed'),
                            ],
                          ),
                          const SizedBox(width: 132),
                          Column(
                            children: [
                              const Text(
                                'Planned time',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              (widget.order.plannedDate != null)
                                  ? Text(
                                      '${DateFormat.Hm().format(widget.order.plannedDate!)} - ${DateFormat.Hm().format(widget.order.plannedDate!.add(Duration(minutes: 90)))}',
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : const Text('Please confirmed'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8.0),
                        child: widget.isConfirmed == false
                            ? ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        BlocProvider<ModalSheetCubit>(
                                      create: (context) => ModalSheetCubit(),
                                      child: EditAddressModalBottomSheet(
                                        order: widget.order,
                                        orderCubit: BlocProvider.of<OrderCubit>(
                                          context,
                                        ),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      widget.isConfirmed == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'TU PEDIDO ESTA\nEN CAMINO',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${DateFormat('HH:mm', 'es').format(widget.order.plannedDate!)}\n${DateFormat('HH:mm', 'es').format(widget.order.plannedDate!.add(Duration(minutes: widget.order.plannedDateDuration ?? 120)))}',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(Icons.arrow_downward),
                                Text(
                                  'POR FAVOR AYUDANOS A ENCONTRAR\nTU UBICACION EXACTA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_downward),
                              ],
                            ),
                      SizedBox(height: 12),
                      Container(
                        width: 480,
                        height: 400,
                        child: Center(
                          child: BlocProvider<AdressCubit>(
                            create: (context) => AdressCubit(),
                            child: Visibility(
                              visible: _isMapVisible,
                              child: widget.isConfirmed
                                  ? SecondMapWidget(
                                      order: widget.order,
                                    )
                                  : MapWidget(
                                      order: widget.order,
                                      orderCubit:
                                          BlocProvider.of<OrderCubit>(context),
                                      onCoordsChange: (newCoords) =>
                                          coords = newCoords,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      widget.isConfirmed == false
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
                                          'ПОЖАЛУЙСТА ВЫБЕРИТЕ УДОБНОЕ\nВАМ ВРЕМЯ ДЛЯ ДОСТАВКИ',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(Icons.arrow_downward),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      child: ElevatedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _currentTime == ''
                                                  ? '${DateFormat.Hm().format(widget.order.plannedDate!)} - ${DateFormat.Hm().format(widget.order.plannedDate!.add(Duration(minutes: 90)))}'
                                                  : _currentTime,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Icon(Icons.arrow_drop_down)
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(120, 50),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12),
                                          primary: Colors.white,
                                          onPrimary: const Color(0XFF557EF1),
                                          side: const BorderSide(
                                              color: Color(0XFF557EF1)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isMapVisible = false;
                                          });
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CupertinoActionSheet(
                                              actions: <Widget>[
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '08:30 - 10:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '08:30 - 10:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 08:30Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    90);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '09:00 - 11:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '09:00 - 11:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 09:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '10:00 - 12:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '10:00 - 12:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 10:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '11:00 - 13:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '11:00 - 13:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 11:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '12:00 - 14:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '12:00 - 14:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 12:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '13:00 - 15:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '13:00 - 15:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 13:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '14:00 - 16:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '14:00 - 16:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 14:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '15:00 - 17:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '15:00 - 17:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 15:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child:
                                                      CupertinoActionSheetAction(
                                                    child: const Text(
                                                      '16:00 - 18:00',
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _isMapVisible = true;
                                                        _currentTime =
                                                            '16:00 - 18:00';
                                                        String _formatedDate =
                                                            DateFormat(
                                                                    'yyyy-M-dd')
                                                                .format(widget
                                                                    .order
                                                                    .plannedDate!);
                                                        DateTime _selectedTime =
                                                            DateTime.parse(
                                                                '$_formatedDate 16:00Z');
                                                        _order = widget.order
                                                            .copyWith(
                                                                plannedDate:
                                                                    _selectedTime,
                                                                plannedDateDuration:
                                                                    120);
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                              cancelButton:
                                                  CupertinoActionSheetAction(
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
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_order != null) {
                                          BlocProvider.of<OrderCubit>(context)
                                              .updateOrder(_order!);
                                          BlocProvider.of<AdressCubit>(context)
                                              .updateCoords(
                                                  coords,
                                                  _order!.client.address.id,
                                                  _order!.shortCode,
                                                  _order!.client.phone);
                                        } else {
                                          BlocProvider.of<OrderCubit>(context)
                                              .updateOrder(widget.order);
                                          BlocProvider.of<AdressCubit>(context)
                                              .updateCoords(
                                                  coords,
                                                  widget
                                                      .order.client.address.id,
                                                  widget.order.shortCode,
                                                  widget.order.client.phone);
                                        }
                                      },
                                      child: const Text(
                                        'ПОЖАЛУЙСТА ПОДТВЕРДИТЕ ВРЕМЯ И АДРЕС ДОСТАВКИ',
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
                            : const EdgeInsets.fromLTRB(12, 12, 12, 48),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
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
}

class TimePickerChips extends StatefulWidget {
  const TimePickerChips({Key? key}) : super(key: key);

  @override
  TimePickerChipsState createState() => TimePickerChipsState();
}

class TimePickerChipsState extends State<TimePickerChips> {
  final List<String> _timeRangeList = [
    '08:30 - 10:00',
    '09:00 - 11:00',
    '11:00 - 13:00',
    '12:00 - 14:00',
    '13:00 - 15:00',
    '14:00 - 16:00',
    '15:00 - 17:00',
    '16:00 - 18:00',
  ];
  int? _selectedValue = 0;
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        _timeRangeList.length,
        (int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
            child: ChoiceChip(
              label: Text(_timeRangeList[index]),
              selected: _selectedValue == index,
              onSelected: (bool selected) {
                setState(() {
                  _selectedValue = selected ? index : null;
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}

class OrderDataPicker extends StatefulWidget {
  const OrderDataPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderDataPicker> createState() => _OrderDataPickerState();
}

class _OrderDataPickerState extends State<OrderDataPicker> {
  DateTime _pickedDate = DateTime(2021, 11, 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Text(
            '${DateFormat('d.M.y').format(_pickedDate)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2021),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).then((newDate) {
                setState(() {
                  _pickedDate = newDate!;
                });
              });
            },
            icon: Icon(Icons.calendar_today, size: 18),
          ),
        ],
      ),
    );
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

class PickedTimeDropDown extends StatefulWidget {
  const PickedTimeDropDown({Key? key}) : super(key: key);

  @override
  _PickedTimeDropDownState createState() => _PickedTimeDropDownState();
}

class _PickedTimeDropDownState extends State<PickedTimeDropDown> {
  List timeRangeList = [
    '08:30 - 10:00',
    '09:00 - 11:00',
    '11:00 - 13:00',
    '12:00 - 14:00',
    '13:00 - 15:00',
    '14:00 - 16:00',
    '15:00 - 17:00',
    '16:00 - 18:00',
  ];
  String dropDownValue = '08:30 - 10:00';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: EdgeInsets.only(top: 16, bottom: 24),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(4)),
      child: DropdownButton<String>(
        elevation: 12,
        underline: SizedBox(),
        isDense: true,
        value: dropDownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropDownValue = newValue!;
          });
        },
        items: timeRangeList
            .map((timeRange) => DropdownMenuItem<String>(
                value: timeRange, child: Text(timeRange)))
            .toList(),
      ),
    );
  }
}
