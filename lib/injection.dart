import 'package:dio/dio.dart';
import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:dtk_store/presenter/order/cubit/order_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  registerBloc();
  // //! Repository
  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: sl()));

  // //! Datasources
  sl.registerLazySingleton<OrderDataSource>(() => OrderDataSourceImpl());

  final options = BaseOptions(
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  sl.registerLazySingleton(() => Dio(options));
  // registerHasuraClient();
}

void registerBloc() {
  sl.registerLazySingleton(() => OrderCubit());

  // sl.registerLazySingleton(() => OrderListBloc());
}

// void registerHasuraClient() {
//   final _httpLink = HttpLink('https://hasura.zaslogistica.com/v1/graphql');
// }
