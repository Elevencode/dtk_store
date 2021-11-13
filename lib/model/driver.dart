import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver.freezed.dart';
part 'driver.g.dart';

@freezed
abstract class Driver implements _$Driver {
  const Driver._();

  factory Driver({
    required DateTime time,
    required double lat,
    required double lng,
  }) = _Driver;
  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
}
