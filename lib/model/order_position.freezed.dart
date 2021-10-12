// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_position.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderPosition _$OrderPositionFromJson(Map<String, dynamic> json) {
  return _OrderPosition.fromJson(json);
}

/// @nodoc
class _$OrderPositionTearOff {
  const _$OrderPositionTearOff();

  _OrderPosition call(
      {required Product product,
      required int quantity,
      int? id,
      int? orderID,
      int? price,
      int? totalPrice}) {
    return _OrderPosition(
      product: product,
      quantity: quantity,
      id: id,
      orderID: orderID,
      price: price,
      totalPrice: totalPrice,
    );
  }

  OrderPosition fromJson(Map<String, Object?> json) {
    return OrderPosition.fromJson(json);
  }
}

/// @nodoc
const $OrderPosition = _$OrderPositionTearOff();

/// @nodoc
mixin _$OrderPosition {
  Product get product => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  int? get orderID => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  int? get totalPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderPositionCopyWith<OrderPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderPositionCopyWith<$Res> {
  factory $OrderPositionCopyWith(
          OrderPosition value, $Res Function(OrderPosition) then) =
      _$OrderPositionCopyWithImpl<$Res>;
  $Res call(
      {Product product,
      int quantity,
      int? id,
      int? orderID,
      int? price,
      int? totalPrice});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$OrderPositionCopyWithImpl<$Res>
    implements $OrderPositionCopyWith<$Res> {
  _$OrderPositionCopyWithImpl(this._value, this._then);

  final OrderPosition _value;
  // ignore: unused_field
  final $Res Function(OrderPosition) _then;

  @override
  $Res call({
    Object? product = freezed,
    Object? quantity = freezed,
    Object? id = freezed,
    Object? orderID = freezed,
    Object? price = freezed,
    Object? totalPrice = freezed,
  }) {
    return _then(_value.copyWith(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPrice: totalPrice == freezed
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
abstract class _$OrderPositionCopyWith<$Res>
    implements $OrderPositionCopyWith<$Res> {
  factory _$OrderPositionCopyWith(
          _OrderPosition value, $Res Function(_OrderPosition) then) =
      __$OrderPositionCopyWithImpl<$Res>;
  @override
  $Res call(
      {Product product,
      int quantity,
      int? id,
      int? orderID,
      int? price,
      int? totalPrice});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$OrderPositionCopyWithImpl<$Res>
    extends _$OrderPositionCopyWithImpl<$Res>
    implements _$OrderPositionCopyWith<$Res> {
  __$OrderPositionCopyWithImpl(
      _OrderPosition _value, $Res Function(_OrderPosition) _then)
      : super(_value, (v) => _then(v as _OrderPosition));

  @override
  _OrderPosition get _value => super._value as _OrderPosition;

  @override
  $Res call({
    Object? product = freezed,
    Object? quantity = freezed,
    Object? id = freezed,
    Object? orderID = freezed,
    Object? price = freezed,
    Object? totalPrice = freezed,
  }) {
    return _then(_OrderPosition(
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      orderID: orderID == freezed
          ? _value.orderID
          : orderID // ignore: cast_nullable_to_non_nullable
              as int?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      totalPrice: totalPrice == freezed
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderPosition extends _OrderPosition {
  _$_OrderPosition(
      {required this.product,
      required this.quantity,
      this.id,
      this.orderID,
      this.price,
      this.totalPrice})
      : super._();

  factory _$_OrderPosition.fromJson(Map<String, dynamic> json) =>
      _$$_OrderPositionFromJson(json);

  @override
  final Product product;
  @override
  final int quantity;
  @override
  final int? id;
  @override
  final int? orderID;
  @override
  final int? price;
  @override
  final int? totalPrice;

  @override
  String toString() {
    return 'OrderPosition(product: $product, quantity: $quantity, id: $id, orderID: $orderID, price: $price, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderPosition &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orderID, orderID) || other.orderID == orderID) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, product, quantity, id, orderID, price, totalPrice);

  @JsonKey(ignore: true)
  @override
  _$OrderPositionCopyWith<_OrderPosition> get copyWith =>
      __$OrderPositionCopyWithImpl<_OrderPosition>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderPositionToJson(this);
  }
}

abstract class _OrderPosition extends OrderPosition {
  factory _OrderPosition(
      {required Product product,
      required int quantity,
      int? id,
      int? orderID,
      int? price,
      int? totalPrice}) = _$_OrderPosition;
  _OrderPosition._() : super._();

  factory _OrderPosition.fromJson(Map<String, dynamic> json) =
      _$_OrderPosition.fromJson;

  @override
  Product get product;
  @override
  int get quantity;
  @override
  int? get id;
  @override
  int? get orderID;
  @override
  int? get price;
  @override
  int? get totalPrice;
  @override
  @JsonKey(ignore: true)
  _$OrderPositionCopyWith<_OrderPosition> get copyWith =>
      throw _privateConstructorUsedError;
}
