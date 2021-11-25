import 'package:dtk_store/core/utils/date_time_extension.dart';
import 'package:dtk_store/core/utils/get_time_range.dart';
import 'package:dtk_store/model/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Contact extends StatelessWidget {
  const Contact({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  text: order.client.fullname,
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
                  text: order.client.address!.district,
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
                  text: order.client.address!.city,
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
                  text: order.client.address!.street,
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
                  text: order.client.address!.country,
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
                  (order.plannedDate != null)
                      ? Text(
                          '${DateFormat.MMMMd().format(order.plannedDate!)} '
                          '${order.plannedDate!.isToday ? '(Hoy)' : ''}',
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 18),
                        )
                      : const Text('Por favor, confirme'),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'Tiempo previsto',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  (order.plannedDate != null)
                      ? Text(
                          getTimeRange(
                            order.plannedDate!,
                            order.plannedDateDuration!,
                            ' - ',
                          ),
                          textAlign: TextAlign.end,
                          style: const TextStyle(fontSize: 18),
                        )
                      : const Text('Por favor, confirme'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
