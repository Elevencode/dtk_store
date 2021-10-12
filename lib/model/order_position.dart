import 'package:dtk_store/model/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_position.freezed.dart';
part 'order_position.g.dart';

@freezed
abstract class OrderPosition implements _$OrderPosition {
  const OrderPosition._();

  factory OrderPosition({
    required Product product,
    required int quantity,
    int? id,
    int? orderID,
    int? price,
    int? totalPrice,
  }) = _OrderPosition;

  factory OrderPosition.fromJson(Map<String, dynamic> json) => _$OrderPositionFromJson(json);
}
