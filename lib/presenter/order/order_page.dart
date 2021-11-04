import 'package:dtk_store/presenter/address/cubit/adress_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/model/order.dart';
import '/presenter/address/address_page.dart';
import '/presenter/order/cubit/order_cubit.dart';
import '/presenter/order/modal_sheet/edit_address_modal.dart';
import '/presenter/promo_box.dart';

import 'modal_sheet/cubit/modal_sheet_cubit.dart';

class OrderPage extends StatelessWidget {
  OrderPage({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        if (state is OrderLoadSuccessState) {
          Order order = state.order;
          return SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'YOUR ORDER ${order.shortCode}',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Color(0XFF557EF1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: [
                            ...order.positions!.asMap().entries.map((item) {
                              int itemIndex = item.key;
                              String productName = item.value.product.name;

                              return Text(
                                '$productName${itemIndex == order.positions!.length - 1 ? '' : ' + '}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Color(0XFF557EF1),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            })
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text(
                                  'PRECIO',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'REGULAR',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${order.totalCents! * 2.8}/s',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
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
                              children: const [
                                Text(
                                  'PRECIO',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'PARA TI',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Text(
                              //TODO: Цена со скидкой
                              '${order.totalCents}/s',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
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
                        height: 240,
                        child: ScrollConfiguration(
                          behavior: PositionsScrollBehavior(),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            controller: _positionsScrollContorller,
                            physics: const PageScrollPhysics(),
                            children: [
                              ...order.positions!
                                  .map(
                                    (items) => SizedBox(
                                      width: 160,
                                      height: 240,
                                      child: Image.asset(
                                        productImagePath[items.product.name],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        bottom: -40,
                        child: PromoBox(),
                      )
                    ],
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: order.client!.fullname,
                                style: const TextStyle(fontSize: 18),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: order.client!.address!.district,
                                style: const TextStyle(fontSize: 18),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: order.client!.address!.city,
                                style: const TextStyle(fontSize: 18),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: order.client!.address!.street,
                                style: const TextStyle(fontSize: 18),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: order.client!.address!.country,
                                style: const TextStyle(fontSize: 18),
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
                                (order.plannedDate != null)
                                    ? Text(
                                        '${DateFormat.MMMMd().format(order.plannedDate!)} ${order.plannedDate == DateTime.now() ? '(Today)' : ''}',
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
                                (order.plannedDate != null)
                                    ? Text(
                                        '${DateFormat.Hm().format(order.plannedDate!)} - ${DateFormat.Hm().format(order.plannedDate!.add(Duration(minutes: 90)))}',
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
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        BlocProvider<ModalSheetCubit>(
                                      create: (context) => ModalSheetCubit(),
                                      child: EditAddressModalBottomSheet(
                                        order: order,
                                        orderCubit: BlocProvider.of<OrderCubit>(
                                            context),
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
                                      MediaQuery.of(context).size.width, 80),
                                  primary: const Color(0XFF557EF1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: ElevatedButton(
                                //todo: открывать страницу карты
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              BlocProvider<AdressCubit>(
                                                create: (context) =>
                                                    AdressCubit(),
                                                child: AddressPage(
                                                  order: state.order,
                                                  orderCubit: BlocProvider.of<
                                                      OrderCubit>(context),
                                                ),
                                              )));
                                },
                                child: const Text(
                                  'CONFIRMAR LA DIRECCION',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 80),
                                  primary: const Color(0XFF67C99C),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        minimumSize:
                            Size(MediaQuery.of(context).size.width - 20, 50),
                        primary: const Color(0XFF557EF1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is OrderLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      },
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
