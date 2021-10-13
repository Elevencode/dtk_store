// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderPosition _$$_OrderPositionFromJson(Map<String, dynamic> json) =>
    _$_OrderPosition(
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      id: json['id'] as int?,
      orderID: json['orderID'] as int?,
      price: json['price'] as int?,
      totalPrice: json['totalPrice'] as int?,
    );

Map<String, dynamic> _$$_OrderPositionToJson(_$_OrderPosition instance) =>
    <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
      'id': instance.id,
      'orderID': instance.orderID,
      'price': instance.price,
      'totalPrice': instance.totalPrice,
    };
