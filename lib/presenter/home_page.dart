import 'package:dtk_store/presenter/promo_box.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 480,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'YOUR ORDER #WER-235-009',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0XFF557EF1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'BIOPROST X3 + ALPHAMAN X1',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0XFF557EF1),
                    fontWeight: FontWeight.bold,
                  ),
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
                      children: [
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
                      '840/s',
                      style: TextStyle(
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
                      children: [
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
                      '279/s',
                      style: TextStyle(
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
          SizedBox(height: 16),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    height: 240,
                    child: Image.asset('assets/images/Bioprost_bottle_big.png'),
                  ),
                  SizedBox(
                    width: 160,
                    height: 240,
                    child: Image.asset('assets/images/Alphaman_small.png'),
                  ),
                  SizedBox(
                    width: 160,
                    height: 240,
                    child: Image.asset('assets/images/Turboslim_20.png'),
                  ),
                ],
              ),
              Positioned(
                bottom: -40,
                child: PromoBox(),
              )
            ],
          ),
          SizedBox(height: 40),
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
                      TextSpan(
                        text: 'Name: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Gabriel Garcia Marces Bernal',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Distrito: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'San Juan De Lurigancho',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Province: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Lima',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Direccion: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'De La Fuente 303, 405',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Referencia: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: 'Puerto rojo',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey[200],
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'Planned time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '22 oct (Today)',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 132),
                    Column(
                      children: [
                        Text(
                          'Planned time',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '22 oct (Today)',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'EDITAR LA DIRECCION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 80),
                          primary: Color(0XFF557EF1),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'CONFIRMAR LA DIRECCION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 80),
                          primary: Color(0XFF67C99C),
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
                minimumSize: Size(MediaQuery.of(context).size.width - 20, 50),
                primary: const Color(0XFF557EF1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
