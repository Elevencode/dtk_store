import 'dart:html';

import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';

abstract class RemoteDataSource {
  Future<Order> getOrder(int id);
  Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<Coordinates> createOrUpdateCoordinates(Address address) {
      // TODO: implement createOrUpdateCoordinates
      throw UnimplementedError();
    }
  
    @override
    Future<Order> getOrder(int id) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<void> updateAddress() {
    // TODO: implement updateAddres
    throw UnimplementedError();
  }
}