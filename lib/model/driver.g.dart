// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Driver _$$_DriverFromJson(Map<String, dynamic> json) => _$_Driver(
      time: DateTime.parse(json['time'] as String),
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$$_DriverToJson(_$_Driver instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'lat': instance.lat,
      'lng': instance.lng,
    };
