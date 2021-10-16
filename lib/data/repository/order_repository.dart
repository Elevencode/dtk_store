import 'dart:html';

import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order.dart';
import 'package:flutter/material.dart';

abstract class OrderRepository {
  Future<Order> getOrder(String shortdcode);
  Future<Client> updateClient(int id);
  // Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<Address> updateAddress(Address address);
}

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.dataSource});

  final OrderDataSource dataSource;

  // @override
  // Future<Coordinates> createOrUpdateCoordinates(Address address) async =>
  //     await dataSource.createOrUpdateCoordinates(address);

  @override
  Future<Order> getOrder(String shortdcode) async => await dataSource.getOrder(shortdcode);

  @override
  Future<Address> updateAddress(Address address) async => await dataSource.updateAddress(address);

  @override
  Future<Client> updateClient(int id) async => await dataSource.updateClient(id);

}
