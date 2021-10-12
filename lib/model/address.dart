import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
abstract class Address with _$Address {
  const Address._();

  factory Address({
    required String city,
    required String street,
    required String country,
    int? id,
    String? state,
    String? district,
    String? comments,
    double? lat,
    double? lng,
  }) = _Address;
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  String get fullAddress => [street, district, state, country]
      .where((part) => part != null && part.isNotEmpty)
      .join(', ');
}
