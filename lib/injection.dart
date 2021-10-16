import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/data/repository/order_repository.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // //! Repository
  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(dataSource: sl()));

  // //! Datasources
  sl.registerLazySingleton<OrderDataSource>(() => OrderDataSourceImpl());

  // registerHasuraClient();
}

// void registerHasuraClient() {
//   final _httpLink = HttpLink('https://hasura.zaslogistica.com/v1/graphql');
// }
