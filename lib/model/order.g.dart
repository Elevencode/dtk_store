// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Order _$$_OrderFromJson(Map<String, dynamic> json) => _$_Order(
      id: json['id'] as int,
      plannedDate: DateTime.parse(json['plannedDate'] as String),
      plannedDateDuration: json['plannedDateDuration'] as int?,
      shortCode: json['shortCode'] as String?,
      totalCents: json['totalCents'] as int?,
      shipmentId: json['shipmentId'] as int?,
      positions: (json['positions'] as List<dynamic>?)
          ?.map((e) => OrderPosition.fromJson(e as Map<String, dynamic>))
          .toList(),
      client: json['client'] == null
          ? null
          : Client.fromJson(json['client'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OrderToJson(_$_Order instance) => <String, dynamic>{
      'id': instance.id,
      'plannedDate': instance.plannedDate.toIso8601String(),
      'plannedDateDuration': instance.plannedDateDuration,
      'shortCode': instance.shortCode,
      'totalCents': instance.totalCents,
      'shipmentId': instance.shipmentId,
      'positions': instance.positions,
      'client': instance.client,
    };
