import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/presenter/order/bloc/order_bloc.dart';
import 'package:dtk_store/presenter/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/order_repository.dart';

void main() async {
  await init();
  final OrderRepository repository = sl();
  late Order order;
  try {
    final result = await repository.getOrder('137', '+555555975');
    print(result);
    order = result;
  } catch (e) {
    print(e.toString());
  }
  runApp(MyApp(
    order: order,
  ));
}

class MyApp extends StatelessWidget {
  final Order order;
  const MyApp({Key? key, required this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => sl<OrderBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: HomePage(
              order: order,
            ),
          ),
        ),
      ),
    );
  }
}
