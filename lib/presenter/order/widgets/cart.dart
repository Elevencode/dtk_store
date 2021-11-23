import 'package:dtk_store/model/order.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatelessWidget {
  Cart({
    Key? key,
    required this.order,
    required this.isConfirmed,
    required this.productImagePath,
    ScrollController? positionsScrollContorller,
  })  : _positionsScrollContorller =
            positionsScrollContorller ?? ScrollController(),
        super(key: key);

  final Order order;
  final bool isConfirmed;
  final ScrollController _positionsScrollContorller;
  final Map productImagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                Text(
                  'TU PEDIDO #${order.shortCode}',
                  style: const TextStyle(
                    fontSize: 32,
                    color: Color(0XFF557EF1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isConfirmed)
                  const Text(
                    'la entrega del pedido!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const Divider(),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ...order.positions.asMap().entries.map(
                      (item) {
                        var itemIndex = item.key;
                        var productName = item.value.product.name.toUpperCase();
                        if (itemIndex != order.positions.length - 1) {
                          productName += ' + ';
                        }
                        return Text(
                          productName,
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
                    '${(order.totalCents * 2.8).round()}/s',
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
                    '${order.totalCents.round()}/s',
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
                      ...order.positions
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
            ],
          ),
        ],
      ),
    );
  }
} //*Без этого класса не работает скролл в ListView

class PositionsScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
