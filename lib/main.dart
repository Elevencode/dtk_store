import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/presenter/order/order_page.dart';
import 'package:flutter/material.dart';

import 'data/repository/order_repository.dart';

void main() async {
  await init();
  final OrderRepository repository = sl();
  try {
    final result = await repository.getOrder('137', '+555555975');
    print(result);
  } catch (e) {
    print(e.toString());
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}
