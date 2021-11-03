import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'package:dtk_store/injection.dart' show init, sl;
import 'package:dtk_store/presenter/order/order_page.dart';

//Convention: при импорте файлов проекта использовать короткую форму записи, без 'package:...'
import 'injection.dart' show init, sl;
import 'presenter/order/order_page.dart';
import 'presenter/order/cubit/order_cubit.dart';

void main() async {
  await init();
  setPathUrlStrategy();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late Widget _rootWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<OrderCubit>(),
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          var name = settings.name!;

          ///Создаём [_rootWidget]
          if (name.contains('phone') && name.contains('code')) {
            var shortCode = Uri.parse(name).queryParameters['code'];
            var phone = Uri.parse(name).queryParameters['phone'];

            _rootWidget = Builder(
              builder: (context) {
                BlocProvider.of<OrderCubit>(context).getOrder(
                  shortCode!,
                  '+${phone!}',
                );

                return OrderPage();
              },
            );
          } else {
            _rootWidget = const Text('Phone and ShortCode is required');
          }

          ///Используем [_rootWidget]
          return PageRouteBuilder(
            maintainState: true,
            settings: RouteSettings(name: name),
            pageBuilder: (context, animation, secondaryAnimation) => SafeArea(
              child: Scaffold(
                body: _rootWidget,
              ),
            ),
          );
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
