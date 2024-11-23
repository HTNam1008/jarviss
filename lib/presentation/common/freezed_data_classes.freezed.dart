// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignInObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Create a copy of SignInObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignInObjectCopyWith<SignInObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignInObjectCopyWith<$Res> {
  factory $SignInObjectCopyWith(
          SignInObject value, $Res Function(SignInObject) then) =
      _$SignInObjectCopyWithImpl<$Res, SignInObject>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$SignInObjectCopyWithImpl<$Res, $Val extends SignInObject>
    implements $SignInObjectCopyWith<$Res> {
  _$SignInObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignInObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignInObjectImplCopyWith<$Res>
    implements $SignInObjectCopyWith<$Res> {
  factory _$$SignInObjectImplCopyWith(
          _$SignInObjectImpl value, $Res Function(_$SignInObjectImpl) then) =
      __$$SignInObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$SignInObjectImplCopyWithImpl<$Res>
    extends _$SignInObjectCopyWithImpl<$Res, _$SignInObjectImpl>
    implements _$$SignInObjectImplCopyWith<$Res> {
  __$$SignInObjectImplCopyWithImpl(
      _$SignInObjectImpl _value, $Res Function(_$SignInObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignInObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$SignInObjectImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignInObjectImpl implements _SignInObject {
  const _$SignInObjectImpl({required this.email, required this.password});

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'SignInObject(email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignInObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  /// Create a copy of SignInObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignInObjectImplCopyWith<_$SignInObjectImpl> get copyWith =>
      __$$SignInObjectImplCopyWithImpl<_$SignInObjectImpl>(this, _$identity);
}

abstract class _SignInObject implements SignInObject {
  const factory _SignInObject(
      {required final String email,
      required final String password}) = _$SignInObjectImpl;

  @override
  String get email;
  @override
  String get password;

  /// Create a copy of SignInObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignInObjectImplCopyWith<_$SignInObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignUpObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;

  /// Create a copy of SignUpObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignUpObjectCopyWith<SignUpObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpObjectCopyWith<$Res> {
  factory $SignUpObjectCopyWith(
          SignUpObject value, $Res Function(SignUpObject) then) =
      _$SignUpObjectCopyWithImpl<$Res, SignUpObject>;
  @useResult
  $Res call({String email, String password, String username});
}

/// @nodoc
class _$SignUpObjectCopyWithImpl<$Res, $Val extends SignUpObject>
    implements $SignUpObjectCopyWith<$Res> {
  _$SignUpObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignUpObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? username = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpObjectImplCopyWith<$Res>
    implements $SignUpObjectCopyWith<$Res> {
  factory _$$SignUpObjectImplCopyWith(
          _$SignUpObjectImpl value, $Res Function(_$SignUpObjectImpl) then) =
      __$$SignUpObjectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password, String username});
}

/// @nodoc
class __$$SignUpObjectImplCopyWithImpl<$Res>
    extends _$SignUpObjectCopyWithImpl<$Res, _$SignUpObjectImpl>
    implements _$$SignUpObjectImplCopyWith<$Res> {
  __$$SignUpObjectImplCopyWithImpl(
      _$SignUpObjectImpl _value, $Res Function(_$SignUpObjectImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignUpObject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
    Object? username = null,
  }) {
    return _then(_$SignUpObjectImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignUpObjectImpl implements _SignUpObject {
  const _$SignUpObjectImpl(
      {required this.email, required this.password, required this.username});

  @override
  final String email;
  @override
  final String password;
  @override
  final String username;

  @override
  String toString() {
    return 'SignUpObject(email: $email, password: $password, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpObjectImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password, username);

  /// Create a copy of SignUpObject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      __$$SignUpObjectImplCopyWithImpl<_$SignUpObjectImpl>(this, _$identity);
}

abstract class _SignUpObject implements SignUpObject {
  const factory _SignUpObject(
      {required final String email,
      required final String password,
      required final String username}) = _$SignUpObjectImpl;

  @override
  String get email;
  @override
  String get password;
  @override
  String get username;

  /// Create a copy of SignUpObject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignUpObjectImplCopyWith<_$SignUpObjectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
