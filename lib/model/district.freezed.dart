// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'district.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

District _$DistrictFromJson(Map<String, dynamic> json) {
  return _District.fromJson(json);
}

/// @nodoc
class _$DistrictTearOff {
  const _$DistrictTearOff();

  _District call({required String name, required String id}) {
    return _District(
      name: name,
      id: id,
    );
  }

  District fromJson(Map<String, Object?> json) {
    return District.fromJson(json);
  }
}

/// @nodoc
const $District = _$DistrictTearOff();

/// @nodoc
mixin _$District {
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DistrictCopyWith<District> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistrictCopyWith<$Res> {
  factory $DistrictCopyWith(District value, $Res Function(District) then) =
      _$DistrictCopyWithImpl<$Res>;
  $Res call({String name, String id});
}

/// @nodoc
class _$DistrictCopyWithImpl<$Res> implements $DistrictCopyWith<$Res> {
  _$DistrictCopyWithImpl(this._value, this._then);

  final District _value;
  // ignore: unused_field
  final $Res Function(District) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$DistrictCopyWith<$Res> implements $DistrictCopyWith<$Res> {
  factory _$DistrictCopyWith(_District value, $Res Function(_District) then) =
      __$DistrictCopyWithImpl<$Res>;
  @override
  $Res call({String name, String id});
}

/// @nodoc
class __$DistrictCopyWithImpl<$Res> extends _$DistrictCopyWithImpl<$Res>
    implements _$DistrictCopyWith<$Res> {
  __$DistrictCopyWithImpl(_District _value, $Res Function(_District) _then)
      : super(_value, (v) => _then(v as _District));

  @override
  _District get _value => super._value as _District;

  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_District(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_District extends _District {
  _$_District({required this.name, required this.id}) : super._();

  factory _$_District.fromJson(Map<String, dynamic> json) =>
      _$$_DistrictFromJson(json);

  @override
  final String name;
  @override
  final String id;

  @override
  String toString() {
    return 'District(name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _District &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id);

  @JsonKey(ignore: true)
  @override
  _$DistrictCopyWith<_District> get copyWith =>
      __$DistrictCopyWithImpl<_District>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DistrictToJson(this);
  }
}

abstract class _District extends District {
  factory _District({required String name, required String id}) = _$_District;
  _District._() : super._();

  factory _District.fromJson(Map<String, dynamic> json) = _$_District.fromJson;

  @override
  String get name;
  @override
  String get id;
  @override
  @JsonKey(ignore: true)
  _$DistrictCopyWith<_District> get copyWith =>
      throw _privateConstructorUsedError;
}
