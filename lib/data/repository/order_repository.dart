import 'dart:html';

import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:flutter/material.dart';

abstract class OrderRepository {
  Future<Order> getOrder(String shortdcode);
  Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress(Address address);
}

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.dataSource});

  final OrderDataSource dataSource;

  @override
  Future<Coordinates> createOrUpdateCoordinates(Address address) async =>
      await dataSource.createOrUpdateCoordinates(address);

  @override
  Future<Order> getOrder(String shortdcode) async => await dataSource.getOrder(shortdcode);

  @override
  Future<void> updateAddress(Address address) async => await dataSource.updateAddress(address);

}
