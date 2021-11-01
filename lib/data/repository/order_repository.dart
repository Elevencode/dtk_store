import 'dart:html';

import 'package:dtk_store/data/datasource/order_datasource.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order.dart';
import 'package:flutter/material.dart';

abstract class OrderRepository {
  Future<Order> getOrder(String shortCode, String phone);
  Future<void> updateClient(
      {required String shortCode, required String phone, required Client client});
  // Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress(
      {required String shortCode, required String phone, required Address address});
}

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.dataSource});

  final OrderDataSource dataSource;

  // @override
  // Future<Coordinates> createOrUpdateCoordinates(Address address) async =>
  //     await dataSource.createOrUpdateCoordinates(address);

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
}
