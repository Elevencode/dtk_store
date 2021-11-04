import 'dart:async';

import 'package:flutter/material.dart';

class PromoBox extends StatefulWidget {
  const PromoBox({Key? key}) : super(key: key);

  @override
  _PromoBoxState createState() => _PromoBoxState();
}

class _PromoBoxState extends State<PromoBox> {
  bool _wantPromo = false;
  int _minutes = 59;
  int _seconds = 59;

  _timerStart() {
    var _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (_seconds >= 1) {
          _seconds -= 1;
        } else if (_minutes > 0 && _seconds == 0) {
          _seconds = 59;
          _minutes -= 1;
        }
      });
    });
    if (_minutes == 0 && _seconds == 0) _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.easeIn,
      secondCurve: Curves.easeIn,
      sizeCurve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      firstChild: Container(
        width: 480,
        color: Colors.white.withOpacity(0.85),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                SizedBox(
                  width: 180,
                  height: 80,
                  child: Text(
                    'ES CONSGUIR\nUNA FRASCA\nMAS GRATIS!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _wantPromo = true;
                });
                _timerStart();
              },
              child: const Text(
                'QUIERO!',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(24),
                primary: Colors.red,
              ),
            )
          ],
        ),
      ),
      secondChild: Container(
        width: 480,
        height: _minutes == 0 && _seconds == 0 ? 93 : 148,
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'PAGUE AHORA CON UNA TARJETA\nY OBTENGA 4 FRASCAS EN LUGAR\nDE 3 POR EL MISMO PRECIO BAJO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 24),
                Text(
                  (_seconds == 0 && _minutes == 0)
                      ? 'Sorry\nPromo time is out!'
                      : '   $_minutes : $_seconds',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: (_seconds == 0 && _minutes == 0) ? 22 : 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _minutes == 0 && _seconds == 0
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.credit_card),
                        Text(
                          '279/S PAGAR PARA IZIPAY',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Icon(Icons.credit_card, color: Colors.transparent),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      minimumSize: Size(80, 60),
                    ),
                  ),
          ],
        ),
      ),
      crossFadeState:
          _wantPromo ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
