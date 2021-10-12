// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
class _$OrderTearOff {
  const _$OrderTearOff();

  _Order call(
      {required int id,
      required DateTime plannedDate,
      int? plannedDateDuration,
      int? totalCents,
      int? shipmentId,
      List<OrderPosition>? positions,
      Client? client}) {
    return _Order(
      id: id,
      plannedDate: plannedDate,
      plannedDateDuration: plannedDateDuration,
      totalCents: totalCents,
      shipmentId: shipmentId,
      positions: positions,
      client: client,
    );
  }

  Order fromJson(Map<String, Object?> json) {
    return Order.fromJson(json);
  }
}

/// @nodoc
const $Order = _$OrderTearOff();

/// @nodoc
mixin _$Order {
  int get id => throw _privateConstructorUsedError; //
// required Status status, //
  DateTime get plannedDate => throw _privateConstructorUsedError; //
// required DateTime createdAt,
// @JsonKey(defaultValue: false) bool? important, //
  int? get plannedDateDuration => throw _privateConstructorUsedError; //
// DateTime? deliveredDate,
// String? umbrellaID,
// String? shortCode,
// String? statusName,
// String? reasonRefusal,
// String? driverID,
  int? get totalCents => throw _privateConstructorUsedError;
  int? get shipmentId =>
      throw _privateConstructorUsedError; // @JsonKey(name: 'order_photos') List<OrderPhoto>? photos,
  List<OrderPosition>? get positions => throw _privateConstructorUsedError;
  Client? get client => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res>;
  $Res call(
      {int id,
      DateTime plannedDate,
      int? plannedDateDuration,
      int? totalCents,
      int? shipmentId,
      List<OrderPosition>? positions,
      Client? client});

  $ClientCopyWith<$Res>? get client;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res> implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  final Order _value;
  // ignore: unused_field
  final $Res Function(Order) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? plannedDate = freezed,
    Object? plannedDateDuration = freezed,
    Object? totalCents = freezed,
    Object? shipmentId = freezed,
    Object? positions = freezed,
    Object? client = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plannedDate: plannedDate == freezed
          ? _value.plannedDate
          : plannedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedDateDuration: plannedDateDuration == freezed
          ? _value.plannedDateDuration
          : plannedDateDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: totalCents == freezed
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      shipmentId: shipmentId == freezed
          ? _value.shipmentId
          : shipmentId // ignore: cast_nullable_to_non_nullable
              as int?,
      positions: positions == freezed
          ? _value.positions
          : positions // ignore: cast_nullable_to_non_nullable
              as List<OrderPosition>?,
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
    ));
  }

  @override
  $ClientCopyWith<$Res>? get client {
    if (_value.client == null) {
      return null;
    }

    return $ClientCopyWith<$Res>(_value.client!, (value) {
      return _then(_value.copyWith(client: value));
    });
  }
}

/// @nodoc
abstract class _$OrderCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$OrderCopyWith(_Order value, $Res Function(_Order) then) =
      __$OrderCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      DateTime plannedDate,
      int? plannedDateDuration,
      int? totalCents,
      int? shipmentId,
      List<OrderPosition>? positions,
      Client? client});

  @override
  $ClientCopyWith<$Res>? get client;
}

/// @nodoc
class __$OrderCopyWithImpl<$Res> extends _$OrderCopyWithImpl<$Res>
    implements _$OrderCopyWith<$Res> {
  __$OrderCopyWithImpl(_Order _value, $Res Function(_Order) _then)
      : super(_value, (v) => _then(v as _Order));

  @override
  _Order get _value => super._value as _Order;

  @override
  $Res call({
    Object? id = freezed,
    Object? plannedDate = freezed,
    Object? plannedDateDuration = freezed,
    Object? totalCents = freezed,
    Object? shipmentId = freezed,
    Object? positions = freezed,
    Object? client = freezed,
  }) {
    return _then(_Order(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      plannedDate: plannedDate == freezed
          ? _value.plannedDate
          : plannedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      plannedDateDuration: plannedDateDuration == freezed
          ? _value.plannedDateDuration
          : plannedDateDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      totalCents: totalCents == freezed
          ? _value.totalCents
          : totalCents // ignore: cast_nullable_to_non_nullable
              as int?,
      shipmentId: shipmentId == freezed
          ? _value.shipmentId
          : shipmentId // ignore: cast_nullable_to_non_nullable
              as int?,
      positions: positions == freezed
          ? _value.positions
          : positions // ignore: cast_nullable_to_non_nullable
              as List<OrderPosition>?,
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as Client?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Order extends _Order {
  _$_Order(
      {required this.id,
      required this.plannedDate,
      this.plannedDateDuration,
      this.totalCents,
      this.shipmentId,
      this.positions,
      this.client})
      : super._();

  factory _$_Order.fromJson(Map<String, dynamic> json) =>
      _$$_OrderFromJson(json);

  @override
  final int id;
  @override //
// required Status status, //
  final DateTime plannedDate;
  @override //
// required DateTime createdAt,
// @JsonKey(defaultValue: false) bool? important, //
  final int? plannedDateDuration;
  @override //
// DateTime? deliveredDate,
// String? umbrellaID,
// String? shortCode,
// String? statusName,
// String? reasonRefusal,
// String? driverID,
  final int? totalCents;
  @override
  final int? shipmentId;
  @override // @JsonKey(name: 'order_photos') List<OrderPhoto>? photos,
  final List<OrderPosition>? positions;
  @override
  final Client? client;

  @override
  String toString() {
    return 'Order(id: $id, plannedDate: $plannedDate, plannedDateDuration: $plannedDateDuration, totalCents: $totalCents, shipmentId: $shipmentId, positions: $positions, client: $client)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Order &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.plannedDate, plannedDate) ||
                other.plannedDate == plannedDate) &&
            (identical(other.plannedDateDuration, plannedDateDuration) ||
                other.plannedDateDuration == plannedDateDuration) &&
            (identical(other.totalCents, totalCents) ||
                other.totalCents == totalCents) &&
            (identical(other.shipmentId, shipmentId) ||
                other.shipmentId == shipmentId) &&
            const DeepCollectionEquality().equals(other.positions, positions) &&
            (identical(other.client, client) || other.client == client));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      plannedDate,
      plannedDateDuration,
      totalCents,
      shipmentId,
      const DeepCollectionEquality().hash(positions),
      client);

  @JsonKey(ignore: true)
  @override
  _$OrderCopyWith<_Order> get copyWith =>
      __$OrderCopyWithImpl<_Order>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderToJson(this);
  }
}

abstract class _Order extends Order {
  factory _Order(
      {required int id,
      required DateTime plannedDate,
      int? plannedDateDuration,
      int? totalCents,
      int? shipmentId,
      List<OrderPosition>? positions,
      Client? client}) = _$_Order;
  _Order._() : super._();

  factory _Order.fromJson(Map<String, dynamic> json) = _$_Order.fromJson;

  @override
  int get id;
  @override //
// required Status status, //
  DateTime get plannedDate;
  @override //
// required DateTime createdAt,
// @JsonKey(defaultValue: false) bool? important, //
  int? get plannedDateDuration;
  @override //
// DateTime? deliveredDate,
// String? umbrellaID,
// String? shortCode,
// String? statusName,
// String? reasonRefusal,
// String? driverID,
  int? get totalCents;
  @override
  int? get shipmentId;
  @override // @JsonKey(name: 'order_photos') List<OrderPhoto>? photos,
  List<OrderPosition>? get positions;
  @override
  Client? get client;
  @override
  @JsonKey(ignore: true)
  _$OrderCopyWith<_Order> get copyWith => throw _privateConstructorUsedError;
}
