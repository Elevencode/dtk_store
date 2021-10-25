// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'order_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$OrderEventTearOff {
  const _$OrderEventTearOff();

  _Started started(String shortCode, String phone) {
    return _Started(
      shortCode,
      phone,
    );
  }

  _EditAddressStarted editAddressStarted({Address? address}) {
    return _EditAddressStarted(
      address: address,
    );
  }

  _SavingAddressStarted savingAddressStarted(
      {required String shortCode,
      required String phone,
      required Address newAddress}) {
    return _SavingAddressStarted(
      shortCode: shortCode,
      phone: phone,
      newAddress: newAddress,
    );
  }

  _ConfirmStarted confirmStarted(Address address) {
    return _ConfirmStarted(
      address,
    );
  }
}

/// @nodoc
const $OrderEvent = _$OrderEventTearOff();

/// @nodoc
mixin _$OrderEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shortCode, String phone) started,
    required TResult Function(Address? address) editAddressStarted,
    required TResult Function(
            String shortCode, String phone, Address newAddress)
        savingAddressStarted,
    required TResult Function(Address address) confirmStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_EditAddressStarted value) editAddressStarted,
    required TResult Function(_SavingAddressStarted value) savingAddressStarted,
    required TResult Function(_ConfirmStarted value) confirmStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEventCopyWith<$Res> {
  factory $OrderEventCopyWith(
          OrderEvent value, $Res Function(OrderEvent) then) =
      _$OrderEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrderEventCopyWithImpl<$Res> implements $OrderEventCopyWith<$Res> {
  _$OrderEventCopyWithImpl(this._value, this._then);

  final OrderEvent _value;
  // ignore: unused_field
  final $Res Function(OrderEvent) _then;
}

/// @nodoc
abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
  $Res call({String shortCode, String phone});
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> extends _$OrderEventCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(_Started _value, $Res Function(_Started) _then)
      : super(_value, (v) => _then(v as _Started));

  @override
  _Started get _value => super._value as _Started;

  @override
  $Res call({
    Object? shortCode = freezed,
    Object? phone = freezed,
  }) {
    return _then(_Started(
      shortCode == freezed
          ? _value.shortCode
          : shortCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started(this.shortCode, this.phone);

  @override
  final String shortCode;
  @override
  final String phone;

  @override
  String toString() {
    return 'OrderEvent.started(shortCode: $shortCode, phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Started &&
            (identical(other.shortCode, shortCode) ||
                other.shortCode == shortCode) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortCode, phone);

  @JsonKey(ignore: true)
  @override
  _$StartedCopyWith<_Started> get copyWith =>
      __$StartedCopyWithImpl<_Started>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shortCode, String phone) started,
    required TResult Function(Address? address) editAddressStarted,
    required TResult Function(
            String shortCode, String phone, Address newAddress)
        savingAddressStarted,
    required TResult Function(Address address) confirmStarted,
  }) {
    return started(shortCode, phone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
  }) {
    return started?.call(shortCode, phone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(shortCode, phone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_EditAddressStarted value) editAddressStarted,
    required TResult Function(_SavingAddressStarted value) savingAddressStarted,
    required TResult Function(_ConfirmStarted value) confirmStarted,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements OrderEvent {
  const factory _Started(String shortCode, String phone) = _$_Started;

  String get shortCode;
  String get phone;
  @JsonKey(ignore: true)
  _$StartedCopyWith<_Started> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$EditAddressStartedCopyWith<$Res> {
  factory _$EditAddressStartedCopyWith(
          _EditAddressStarted value, $Res Function(_EditAddressStarted) then) =
      __$EditAddressStartedCopyWithImpl<$Res>;
  $Res call({Address? address});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$EditAddressStartedCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res>
    implements _$EditAddressStartedCopyWith<$Res> {
  __$EditAddressStartedCopyWithImpl(
      _EditAddressStarted _value, $Res Function(_EditAddressStarted) _then)
      : super(_value, (v) => _then(v as _EditAddressStarted));

  @override
  _EditAddressStarted get _value => super._value as _EditAddressStarted;

  @override
  $Res call({
    Object? address = freezed,
  }) {
    return _then(_EditAddressStarted(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  @override
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value));
    });
  }
}

/// @nodoc

class _$_EditAddressStarted implements _EditAddressStarted {
  const _$_EditAddressStarted({this.address});

  @override
  final Address? address;

  @override
  String toString() {
    return 'OrderEvent.editAddressStarted(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditAddressStarted &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  _$EditAddressStartedCopyWith<_EditAddressStarted> get copyWith =>
      __$EditAddressStartedCopyWithImpl<_EditAddressStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shortCode, String phone) started,
    required TResult Function(Address? address) editAddressStarted,
    required TResult Function(
            String shortCode, String phone, Address newAddress)
        savingAddressStarted,
    required TResult Function(Address address) confirmStarted,
  }) {
    return editAddressStarted(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
  }) {
    return editAddressStarted?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
    required TResult orElse(),
  }) {
    if (editAddressStarted != null) {
      return editAddressStarted(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_EditAddressStarted value) editAddressStarted,
    required TResult Function(_SavingAddressStarted value) savingAddressStarted,
    required TResult Function(_ConfirmStarted value) confirmStarted,
  }) {
    return editAddressStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
  }) {
    return editAddressStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
    required TResult orElse(),
  }) {
    if (editAddressStarted != null) {
      return editAddressStarted(this);
    }
    return orElse();
  }
}

abstract class _EditAddressStarted implements OrderEvent {
  const factory _EditAddressStarted({Address? address}) = _$_EditAddressStarted;

  Address? get address;
  @JsonKey(ignore: true)
  _$EditAddressStartedCopyWith<_EditAddressStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SavingAddressStartedCopyWith<$Res> {
  factory _$SavingAddressStartedCopyWith(_SavingAddressStarted value,
          $Res Function(_SavingAddressStarted) then) =
      __$SavingAddressStartedCopyWithImpl<$Res>;
  $Res call({String shortCode, String phone, Address newAddress});

  $AddressCopyWith<$Res> get newAddress;
}

/// @nodoc
class __$SavingAddressStartedCopyWithImpl<$Res>
    extends _$OrderEventCopyWithImpl<$Res>
    implements _$SavingAddressStartedCopyWith<$Res> {
  __$SavingAddressStartedCopyWithImpl(
      _SavingAddressStarted _value, $Res Function(_SavingAddressStarted) _then)
      : super(_value, (v) => _then(v as _SavingAddressStarted));

  @override
  _SavingAddressStarted get _value => super._value as _SavingAddressStarted;

  @override
  $Res call({
    Object? shortCode = freezed,
    Object? phone = freezed,
    Object? newAddress = freezed,
  }) {
    return _then(_SavingAddressStarted(
      shortCode: shortCode == freezed
          ? _value.shortCode
          : shortCode // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      newAddress: newAddress == freezed
          ? _value.newAddress
          : newAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  @override
  $AddressCopyWith<$Res> get newAddress {
    return $AddressCopyWith<$Res>(_value.newAddress, (value) {
      return _then(_value.copyWith(newAddress: value));
    });
  }
}

/// @nodoc

class _$_SavingAddressStarted implements _SavingAddressStarted {
  const _$_SavingAddressStarted(
      {required this.shortCode, required this.phone, required this.newAddress});

  @override
  final String shortCode;
  @override
  final String phone;
  @override
  final Address newAddress;

  @override
  String toString() {
    return 'OrderEvent.savingAddressStarted(shortCode: $shortCode, phone: $phone, newAddress: $newAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavingAddressStarted &&
            (identical(other.shortCode, shortCode) ||
                other.shortCode == shortCode) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.newAddress, newAddress) ||
                other.newAddress == newAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, shortCode, phone, newAddress);

  @JsonKey(ignore: true)
  @override
  _$SavingAddressStartedCopyWith<_SavingAddressStarted> get copyWith =>
      __$SavingAddressStartedCopyWithImpl<_SavingAddressStarted>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shortCode, String phone) started,
    required TResult Function(Address? address) editAddressStarted,
    required TResult Function(
            String shortCode, String phone, Address newAddress)
        savingAddressStarted,
    required TResult Function(Address address) confirmStarted,
  }) {
    return savingAddressStarted(shortCode, phone, newAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
  }) {
    return savingAddressStarted?.call(shortCode, phone, newAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
    required TResult orElse(),
  }) {
    if (savingAddressStarted != null) {
      return savingAddressStarted(shortCode, phone, newAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_EditAddressStarted value) editAddressStarted,
    required TResult Function(_SavingAddressStarted value) savingAddressStarted,
    required TResult Function(_ConfirmStarted value) confirmStarted,
  }) {
    return savingAddressStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
  }) {
    return savingAddressStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
    required TResult orElse(),
  }) {
    if (savingAddressStarted != null) {
      return savingAddressStarted(this);
    }
    return orElse();
  }
}

abstract class _SavingAddressStarted implements OrderEvent {
  const factory _SavingAddressStarted(
      {required String shortCode,
      required String phone,
      required Address newAddress}) = _$_SavingAddressStarted;

  String get shortCode;
  String get phone;
  Address get newAddress;
  @JsonKey(ignore: true)
  _$SavingAddressStartedCopyWith<_SavingAddressStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ConfirmStartedCopyWith<$Res> {
  factory _$ConfirmStartedCopyWith(
          _ConfirmStarted value, $Res Function(_ConfirmStarted) then) =
      __$ConfirmStartedCopyWithImpl<$Res>;
  $Res call({Address address});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$ConfirmStartedCopyWithImpl<$Res> extends _$OrderEventCopyWithImpl<$Res>
    implements _$ConfirmStartedCopyWith<$Res> {
  __$ConfirmStartedCopyWithImpl(
      _ConfirmStarted _value, $Res Function(_ConfirmStarted) _then)
      : super(_value, (v) => _then(v as _ConfirmStarted));

  @override
  _ConfirmStarted get _value => super._value as _ConfirmStarted;

  @override
  $Res call({
    Object? address = freezed,
  }) {
    return _then(_ConfirmStarted(
      address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  @override
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value));
    });
  }
}

/// @nodoc

class _$_ConfirmStarted implements _ConfirmStarted {
  const _$_ConfirmStarted(this.address);

  @override
  final Address address;

  @override
  String toString() {
    return 'OrderEvent.confirmStarted(address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConfirmStarted &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  _$ConfirmStartedCopyWith<_ConfirmStarted> get copyWith =>
      __$ConfirmStartedCopyWithImpl<_ConfirmStarted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String shortCode, String phone) started,
    required TResult Function(Address? address) editAddressStarted,
    required TResult Function(
            String shortCode, String phone, Address newAddress)
        savingAddressStarted,
    required TResult Function(Address address) confirmStarted,
  }) {
    return confirmStarted(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
  }) {
    return confirmStarted?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String shortCode, String phone)? started,
    TResult Function(Address? address)? editAddressStarted,
    TResult Function(String shortCode, String phone, Address newAddress)?
        savingAddressStarted,
    TResult Function(Address address)? confirmStarted,
    required TResult orElse(),
  }) {
    if (confirmStarted != null) {
      return confirmStarted(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_EditAddressStarted value) editAddressStarted,
    required TResult Function(_SavingAddressStarted value) savingAddressStarted,
    required TResult Function(_ConfirmStarted value) confirmStarted,
  }) {
    return confirmStarted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
  }) {
    return confirmStarted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_EditAddressStarted value)? editAddressStarted,
    TResult Function(_SavingAddressStarted value)? savingAddressStarted,
    TResult Function(_ConfirmStarted value)? confirmStarted,
    required TResult orElse(),
  }) {
    if (confirmStarted != null) {
      return confirmStarted(this);
    }
    return orElse();
  }
}

abstract class _ConfirmStarted implements OrderEvent {
  const factory _ConfirmStarted(Address address) = _$_ConfirmStarted;

  Address get address;
  @JsonKey(ignore: true)
  _$ConfirmStartedCopyWith<_ConfirmStarted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$OrderStateTearOff {
  const _$OrderStateTearOff();

  _LoadSuccess loadSuccess(Order order) {
    return _LoadSuccess(
      order,
    );
  }

  _LoadInProgress loadInProgress() {
    return const _LoadInProgress();
  }

  _EditInitial editIntial(Address? newAddress) {
    return _EditInitial(
      newAddress,
    );
  }

  _LoadFailure loadFailure(String errorText) {
    return _LoadFailure(
      errorText,
    );
  }
}

/// @nodoc
const $OrderState = _$OrderStateTearOff();

/// @nodoc
mixin _$OrderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Order order) loadSuccess,
    required TResult Function() loadInProgress,
    required TResult Function(Address? newAddress) editIntial,
    required TResult Function(String errorText) loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_EditInitial value) editIntial,
    required TResult Function(_LoadFailure value) loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStateCopyWith<$Res> {
  factory $OrderStateCopyWith(
          OrderState value, $Res Function(OrderState) then) =
      _$OrderStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$OrderStateCopyWithImpl<$Res> implements $OrderStateCopyWith<$Res> {
  _$OrderStateCopyWithImpl(this._value, this._then);

  final OrderState _value;
  // ignore: unused_field
  final $Res Function(OrderState) _then;
}

/// @nodoc
abstract class _$LoadSuccessCopyWith<$Res> {
  factory _$LoadSuccessCopyWith(
          _LoadSuccess value, $Res Function(_LoadSuccess) then) =
      __$LoadSuccessCopyWithImpl<$Res>;
  $Res call({Order order});

  $OrderCopyWith<$Res> get order;
}

/// @nodoc
class __$LoadSuccessCopyWithImpl<$Res> extends _$OrderStateCopyWithImpl<$Res>
    implements _$LoadSuccessCopyWith<$Res> {
  __$LoadSuccessCopyWithImpl(
      _LoadSuccess _value, $Res Function(_LoadSuccess) _then)
      : super(_value, (v) => _then(v as _LoadSuccess));

  @override
  _LoadSuccess get _value => super._value as _LoadSuccess;

  @override
  $Res call({
    Object? order = freezed,
  }) {
    return _then(_LoadSuccess(
      order == freezed
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order,
    ));
  }

  @override
  $OrderCopyWith<$Res> get order {
    return $OrderCopyWith<$Res>(_value.order, (value) {
      return _then(_value.copyWith(order: value));
    });
  }
}

/// @nodoc

class _$_LoadSuccess implements _LoadSuccess {
  const _$_LoadSuccess(this.order);

  @override
  final Order order;

  @override
  String toString() {
    return 'OrderState.loadSuccess(order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadSuccess &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, order);

  @JsonKey(ignore: true)
  @override
  _$LoadSuccessCopyWith<_LoadSuccess> get copyWith =>
      __$LoadSuccessCopyWithImpl<_LoadSuccess>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Order order) loadSuccess,
    required TResult Function() loadInProgress,
    required TResult Function(Address? newAddress) editIntial,
    required TResult Function(String errorText) loadFailure,
  }) {
    return loadSuccess(order);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
  }) {
    return loadSuccess?.call(order);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(order);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_EditInitial value) editIntial,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadSuccess != null) {
      return loadSuccess(this);
    }
    return orElse();
  }
}

abstract class _LoadSuccess implements OrderState {
  const factory _LoadSuccess(Order order) = _$_LoadSuccess;

  Order get order;
  @JsonKey(ignore: true)
  _$LoadSuccessCopyWith<_LoadSuccess> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadInProgressCopyWith<$Res> {
  factory _$LoadInProgressCopyWith(
          _LoadInProgress value, $Res Function(_LoadInProgress) then) =
      __$LoadInProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadInProgressCopyWithImpl<$Res> extends _$OrderStateCopyWithImpl<$Res>
    implements _$LoadInProgressCopyWith<$Res> {
  __$LoadInProgressCopyWithImpl(
      _LoadInProgress _value, $Res Function(_LoadInProgress) _then)
      : super(_value, (v) => _then(v as _LoadInProgress));

  @override
  _LoadInProgress get _value => super._value as _LoadInProgress;
}

/// @nodoc

class _$_LoadInProgress implements _LoadInProgress {
  const _$_LoadInProgress();

  @override
  String toString() {
    return 'OrderState.loadInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoadInProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Order order) loadSuccess,
    required TResult Function() loadInProgress,
    required TResult Function(Address? newAddress) editIntial,
    required TResult Function(String errorText) loadFailure,
  }) {
    return loadInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
  }) {
    return loadInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_EditInitial value) editIntial,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadInProgress != null) {
      return loadInProgress(this);
    }
    return orElse();
  }
}

abstract class _LoadInProgress implements OrderState {
  const factory _LoadInProgress() = _$_LoadInProgress;
}

/// @nodoc
abstract class _$EditInitialCopyWith<$Res> {
  factory _$EditInitialCopyWith(
          _EditInitial value, $Res Function(_EditInitial) then) =
      __$EditInitialCopyWithImpl<$Res>;
  $Res call({Address? newAddress});

  $AddressCopyWith<$Res>? get newAddress;
}

/// @nodoc
class __$EditInitialCopyWithImpl<$Res> extends _$OrderStateCopyWithImpl<$Res>
    implements _$EditInitialCopyWith<$Res> {
  __$EditInitialCopyWithImpl(
      _EditInitial _value, $Res Function(_EditInitial) _then)
      : super(_value, (v) => _then(v as _EditInitial));

  @override
  _EditInitial get _value => super._value as _EditInitial;

  @override
  $Res call({
    Object? newAddress = freezed,
  }) {
    return _then(_EditInitial(
      newAddress == freezed
          ? _value.newAddress
          : newAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  @override
  $AddressCopyWith<$Res>? get newAddress {
    if (_value.newAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.newAddress!, (value) {
      return _then(_value.copyWith(newAddress: value));
    });
  }
}

/// @nodoc

class _$_EditInitial implements _EditInitial {
  const _$_EditInitial(this.newAddress);

  @override
  final Address? newAddress;

  @override
  String toString() {
    return 'OrderState.editIntial(newAddress: $newAddress)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditInitial &&
            (identical(other.newAddress, newAddress) ||
                other.newAddress == newAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newAddress);

  @JsonKey(ignore: true)
  @override
  _$EditInitialCopyWith<_EditInitial> get copyWith =>
      __$EditInitialCopyWithImpl<_EditInitial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Order order) loadSuccess,
    required TResult Function() loadInProgress,
    required TResult Function(Address? newAddress) editIntial,
    required TResult Function(String errorText) loadFailure,
  }) {
    return editIntial(newAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
  }) {
    return editIntial?.call(newAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
    required TResult orElse(),
  }) {
    if (editIntial != null) {
      return editIntial(newAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_EditInitial value) editIntial,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return editIntial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return editIntial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (editIntial != null) {
      return editIntial(this);
    }
    return orElse();
  }
}

abstract class _EditInitial implements OrderState {
  const factory _EditInitial(Address? newAddress) = _$_EditInitial;

  Address? get newAddress;
  @JsonKey(ignore: true)
  _$EditInitialCopyWith<_EditInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadFailureCopyWith<$Res> {
  factory _$LoadFailureCopyWith(
          _LoadFailure value, $Res Function(_LoadFailure) then) =
      __$LoadFailureCopyWithImpl<$Res>;
  $Res call({String errorText});
}

/// @nodoc
class __$LoadFailureCopyWithImpl<$Res> extends _$OrderStateCopyWithImpl<$Res>
    implements _$LoadFailureCopyWith<$Res> {
  __$LoadFailureCopyWithImpl(
      _LoadFailure _value, $Res Function(_LoadFailure) _then)
      : super(_value, (v) => _then(v as _LoadFailure));

  @override
  _LoadFailure get _value => super._value as _LoadFailure;

  @override
  $Res call({
    Object? errorText = freezed,
  }) {
    return _then(_LoadFailure(
      errorText == freezed
          ? _value.errorText
          : errorText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoadFailure implements _LoadFailure {
  const _$_LoadFailure(this.errorText);

  @override
  final String errorText;

  @override
  String toString() {
    return 'OrderState.loadFailure(errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoadFailure &&
            (identical(other.errorText, errorText) ||
                other.errorText == errorText));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorText);

  @JsonKey(ignore: true)
  @override
  _$LoadFailureCopyWith<_LoadFailure> get copyWith =>
      __$LoadFailureCopyWithImpl<_LoadFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Order order) loadSuccess,
    required TResult Function() loadInProgress,
    required TResult Function(Address? newAddress) editIntial,
    required TResult Function(String errorText) loadFailure,
  }) {
    return loadFailure(errorText);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
  }) {
    return loadFailure?.call(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Order order)? loadSuccess,
    TResult Function()? loadInProgress,
    TResult Function(Address? newAddress)? editIntial,
    TResult Function(String errorText)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoadSuccess value) loadSuccess,
    required TResult Function(_LoadInProgress value) loadInProgress,
    required TResult Function(_EditInitial value) editIntial,
    required TResult Function(_LoadFailure value) loadFailure,
  }) {
    return loadFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
  }) {
    return loadFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoadSuccess value)? loadSuccess,
    TResult Function(_LoadInProgress value)? loadInProgress,
    TResult Function(_EditInitial value)? editIntial,
    TResult Function(_LoadFailure value)? loadFailure,
    required TResult orElse(),
  }) {
    if (loadFailure != null) {
      return loadFailure(this);
    }
    return orElse();
  }
}

abstract class _LoadFailure implements OrderState {
  const factory _LoadFailure(String errorText) = _$_LoadFailure;

  String get errorText;
  @JsonKey(ignore: true)
  _$LoadFailureCopyWith<_LoadFailure> get copyWith =>
      throw _privateConstructorUsedError;
}
