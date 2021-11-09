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
  Future<void> updateClient(
      {required String shortCode, required String phone, required Client client});
  Future<void> updateAddress(
      {required String shortCode, required String phone, required Address address});
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
  Future<void> createNotificationOperator({required String shortCode, required String phone});
}

class OrderDataSourceImpl implements OrderDataSource {
  OrderDataSourceImpl();

  Dio get dioClient => sl();

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
  Future<void> updateClient(
      {required String shortCode, required String phone, required Client client}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-client'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'client': client.toJson(),
      }),
    );

    if (response.statusCode != 200) {
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<void> updateAddress(
      {required String shortCode, required String phone, required Address address}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-address'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'address': address.toJson(),
      }),
    );

    if (response.statusCode != 200) {
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<void> createNotificationOperator(
      {required String shortCode, required String phone}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/create-notification'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
      }),
    );

    if (response.statusCode != 200) {
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<void> updateOrderTime(
      {required String shortCode,
      required String phone,
      required DateTime plannedDate,
      required int duration}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-order-time'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'plannedDate': plannedDate.toString(),
        'plannedDateDuration': duration,
      }),
    );

    if (response.statusCode != 200) {
      throw ex.ServerException(exception: response);
    }
  }

  @override
  Future<void> updateCoords(
      {required String shortCode,
      required String phone,
      required double lat,
      required double lng,
      required int addressId}) async {
    final response = await http.post(
      Uri.parse('https://api.zaslogistica.com/store/update-address'),
      body: jsonEncode({
        'shortCode': shortCode,
        'phone': phone,
        'address': {
          'lat': lat,
          'lng': lng,
          'id': addressId,
        }
      }),
    );

    if (response.statusCode != 200) {
      throw ex.ServerException(exception: response);
    }
  }
}
