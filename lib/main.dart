import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/presenter/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Convention: при импорте файлов проекта использовать короткую форму записи, без 'package:...'
import 'injection.dart' show init, sl;
import 'presenter/order/order_page.dart';
import 'presenter/order/cubit/order_cubit.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<OrderCubit>()..getOrder(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: HomePage(),
          ),
        ),
      ),
    );
  }
}
