import 'dart:html';

import 'package:dtk_store/data/datasource/remote_datasource.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/order.dart';
import 'package:flutter/material.dart';

abstract class Repository {
  Future<Order> getOrder(int id);
  Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<void> updateAddress();
}

class RepositoryImpl implements Repository {
  RepositoryImpl({required this.dataSource});

  final RemoteDataSource dataSource;

  @override
  Future<Coordinates> createOrUpdateCoordinates(Address address) async =>
      await dataSource.createOrUpdateCoordinates(address);

  @override
  Future<Order> getOrder(int id) async => await dataSource.getOrder(id);

  @override
  Future<void> updateAddress() async => await dataSource.updateAddress();

}
