import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order.dart';

abstract class OrderRepository {
  Future<Order> getOrder(String shortCode, String phone);
  Future<void> updateClient(
      {required String shortCode, required String phone, required Client client});
  // Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress(
      {required String shortCode, required String phone, required Address address});
  Future<void> createNotificationOperator({required String shortCode, required String phone});
  Future<void> updateOrderTime(
      {required String shortCode,
      required String phone,
      required DateTime plannedDate,
      required int duration});
  Future<void> updateCoords(
      {required String shortCode,
      required String phone,
      required double lat,
      required double lng,
      required int addressId});
}

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.dataSource});

  final OrderDataSource dataSource;

  @override
  Future<Order> getOrder(String shortCode, String phone) async =>
      await dataSource.getOrder(shortCode, phone);

  @override
  Future<void> updateClient(
          {required String shortCode, required String phone, required Client client}) async =>
      await dataSource.updateClient(shortCode: shortCode, phone: phone, client: client);

  @override
  Future<void> updateAddress(
          {required String shortCode, required String phone, required Address address}) async =>
      await dataSource.updateAddress(shortCode: shortCode, phone: phone, address: address);

  @override
  Future<void> createNotificationOperator(
          {required String shortCode, required String phone}) async =>
      dataSource.createNotificationOperator(shortCode: shortCode, phone: phone);

  @override
  Future<void> updateOrderTime(
      {required String shortCode,
      required String phone,
      required DateTime plannedDate,
      required int duration}) async {
    await dataSource.updateOrderTime(
        shortCode: shortCode,
        phone: phone,
        plannedDate: plannedDate,
        duration: duration);
  }

  @override
  Future<void> updateCoords(
      {required String shortCode,
      required String phone,
      required double lat,
      required double lng,
      required int addressId}) async {
    await dataSource.updateCoords(
        shortCode: shortCode,
        phone: phone,
        lat: lat,
        lng: lng,
        addressId: addressId);
  }
}
