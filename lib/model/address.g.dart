// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Address _$$_AddressFromJson(Map<String, dynamic> json) => _$_Address(
      city: json['city'] as String,
      street: json['street'] as String,
      country: json['country'] as String,
      id: json['id'] as int,
      state: json['state'] as String?,
      district: json['district'] as String,
      comments: json['comments'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'country': instance.country,
      'id': instance.id,
      'state': instance.state,
      'district': instance.district,
      'comments': instance.comments,
      'lat': instance.lat,
      'lng': instance.lng,
    };
