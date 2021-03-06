import 'package:dtk_store/model/address.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'district.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@freezed
abstract class Client implements _$Client {
  const Client._();

  factory Client({
    required String phone,
    required String fullname,
    Address? address,
    District? district,
    required int id,
  }) = _Client;

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
}
