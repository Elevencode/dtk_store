import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dtk_store/model/address.dart';
import 'package:dtk_store/model/client.dart';
import 'package:dtk_store/model/order.dart';
import 'package:dtk_store/core/error/exceptions.dart' as ex;
import 'package:http/http.dart' as http;

import '../../injection.dart';

abstract class OrderDataSource {
  Future<Order> getOrder(String shortCode, String phone);
  Future<Client> updateClient(
      {required String shortCode, required String phone, required Client client});
  // Future<Coordinates> createOrUpdateCoordinates(Address address);
  Future<Address> updateAddress(
      {required String shortCode, required String phone, required Address address});
}

class OrderDataSourceImpl implements OrderDataSource {
  OrderDataSourceImpl();

  Dio get dioClient => sl();

  // @override
  // Future<Coordinates> createOrUpdateCoordinates(Address address) {
  //     // TODO: implement createOrUpdateCoordinates
  //     throw UnimplementedError();
  //   }

  @override
  Future<Order> getOrder(String shortCode, String phone) async {
    final response = await dioClient.get(
      'https://api.zaslogistica.com/store/get-order',
      queryParameters: {
        'shortCode': shortCode,
        'phone': phone,
      },
    );

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.data!));
    } else {
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<Client> updateClient(
      {required String shortCode, required String phone, required Client client}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-client'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'client': client.toJson(),
      }),
    );

    if (response.statusCode == 200) {
      return Client.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<Address> updateAddress(
      {required String shortCode, required String phone, required Address address}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-address'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'address': address.toJson(),
      }),
    );
    print(response);

    if (response.statusCode == 200) {
      return Address.fromJson(json.decode(response.body));
    } else {
      throw ex.ServerException(exception: response);
    }
  }
}
