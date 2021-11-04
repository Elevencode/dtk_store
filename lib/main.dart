import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/presenter/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

//Convention: при импорте файлов проекта использовать короткую форму записи, без 'package:...'
import 'injection.dart' show init, sl;
import 'presenter/address/cubit/adress_cubit.dart';
import 'presenter/order/modal_sheet/cubit/modal_sheet_cubit.dart';
import 'presenter/order/order_page.dart';
import 'presenter/order/cubit/order_cubit.dart';

void main() async {
  await init();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (BuildContext context) => sl<OrderCubit>()..getOrder(),
        ),
        BlocProvider<AdressCubit>(
          create: (context) => AdressCubit(),
        ),
        BlocProvider<ModalSheetCubit>(
          create: (context) => ModalSheetCubit(),
        ),
      ],
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
