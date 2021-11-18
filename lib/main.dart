import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/presenter/order/order_page.dart';

//Convention: при импорте файлов проекта использовать короткую форму записи, без 'package:...'
import 'injection.dart' show init, sl;
import 'presenter/address/cubit/map_widget_cubit.dart';
import 'presenter/order/modal_sheet/cubit/modal_sheet_cubit.dart';
import 'presenter/order/order_page.dart';
import 'presenter/order/cubit/order_cubit.dart';

void main() async {
  await init();
  await initializeDateFormatting('pt_BR', null);
  setPathUrlStrategy();
  // debugger();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (BuildContext context) => sl<OrderCubit>(),
        ),
        BlocProvider<AddressCubit>(
          create: (context) => AddressCubit(),
        ),
        BlocProvider<ModalSheetCubit>(
          create: (context) => ModalSheetCubit(),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          var name = settings.name;

          if (name != null && name.contains('phone') && name.contains('code')) {
            var shortCode = Uri.parse(name).queryParameters['code'];
            var phone = Uri.parse(name).queryParameters['phone'];
            return PageRouteBuilder(
              maintainState: true,
              settings: RouteSettings(name: name),
              pageBuilder: (context, animation, secondaryAnimation) => SafeArea(
                child: Scaffold(
                  body: Builder(
                    builder: (context) {
                      BlocProvider.of<OrderCubit>(context)
                        ..initOrderCubit(
                          shortCode!,
                          '+${phone!}',
                        )
                        ..getOrder();
                      return const OrderPage();
                    },
                  ),
                ),
              ),
            );
          } else {
            return PageRouteBuilder(
              maintainState: true,
              settings: RouteSettings(name: name),
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SafeArea(
                child: Scaffold(
                  body: Text('Phone and ShortCode is required'),
                ),
              ),
            );
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
