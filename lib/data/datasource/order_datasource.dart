import 'dart:html';

import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:graphql/client.dart';

abstract class OrderDataSource {
  Future<Order> getOrder(String shortCode);
  Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress(Address address);
}

class OrderDataSourceImpl implements OrderDataSource {
OrderDataSourceImpl({required this.graphQLClient});

  final GraphQLClient graphQLClient;

  @override
  Future<Coordinates> createOrUpdateCoordinates(Address address) {
      // TODO: implement createOrUpdateCoordinates
      throw UnimplementedError();
    }
  
    @override
    Future<Order> getOrder(String shortcode) {
    // TODO: implement getOrder
    throw UnimplementedError();
  }

  @override
  Future<void> updateAddress(Address address) {
    // TODO: implement updateAddres
    throw UnimplementedError();
  }
}