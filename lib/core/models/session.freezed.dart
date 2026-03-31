// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Session {

 String get id; DateTime get startTime; DateTime? get endTime; Deed? get deedCompleted; bool get bypassUsed; int get barakahEarned;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.deedCompleted, deedCompleted) || other.deedCompleted == deedCompleted)&&(identical(other.bypassUsed, bypassUsed) || other.bypassUsed == bypassUsed)&&(identical(other.barakahEarned, barakahEarned) || other.barakahEarned == barakahEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,deedCompleted,bypassUsed,barakahEarned);

@override
String toString() {
  return 'Session(id: $id, startTime: $startTime, endTime: $endTime, deedCompleted: $deedCompleted, bypassUsed: $bypassUsed, barakahEarned: $barakahEarned)';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startTime, DateTime? endTime, Deed? deedCompleted, bool bypassUsed, int barakahEarned
});


$DeedCopyWith<$Res>? get deedCompleted;

}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = freezed,Object? deedCompleted = freezed,Object? bypassUsed = null,Object? barakahEarned = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,deedCompleted: freezed == deedCompleted ? _self.deedCompleted : deedCompleted // ignore: cast_nullable_to_non_nullable
as Deed?,bypassUsed: null == bypassUsed ? _self.bypassUsed : bypassUsed // ignore: cast_nullable_to_non_nullable
as bool,barakahEarned: null == barakahEarned ? _self.barakahEarned : barakahEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeedCopyWith<$Res>? get deedCompleted {
    if (_self.deedCompleted == null) {
    return null;
  }

  return $DeedCopyWith<$Res>(_self.deedCompleted!, (value) {
    return _then(_self.copyWith(deedCompleted: value));
  });
}
}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startTime,  DateTime? endTime,  Deed? deedCompleted,  bool bypassUsed,  int barakahEarned)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.deedCompleted,_that.bypassUsed,_that.barakahEarned);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startTime,  DateTime? endTime,  Deed? deedCompleted,  bool bypassUsed,  int barakahEarned)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.id,_that.startTime,_that.endTime,_that.deedCompleted,_that.bypassUsed,_that.barakahEarned);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startTime,  DateTime? endTime,  Deed? deedCompleted,  bool bypassUsed,  int barakahEarned)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.deedCompleted,_that.bypassUsed,_that.barakahEarned);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Session implements Session {
  const _Session({required this.id, required this.startTime, this.endTime, this.deedCompleted, this.bypassUsed = false, this.barakahEarned = 1});
  factory _Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

@override final  String id;
@override final  DateTime startTime;
@override final  DateTime? endTime;
@override final  Deed? deedCompleted;
@override@JsonKey() final  bool bypassUsed;
@override@JsonKey() final  int barakahEarned;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.deedCompleted, deedCompleted) || other.deedCompleted == deedCompleted)&&(identical(other.bypassUsed, bypassUsed) || other.bypassUsed == bypassUsed)&&(identical(other.barakahEarned, barakahEarned) || other.barakahEarned == barakahEarned));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,deedCompleted,bypassUsed,barakahEarned);

@override
String toString() {
  return 'Session(id: $id, startTime: $startTime, endTime: $endTime, deedCompleted: $deedCompleted, bypassUsed: $bypassUsed, barakahEarned: $barakahEarned)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startTime, DateTime? endTime, Deed? deedCompleted, bool bypassUsed, int barakahEarned
});


@override $DeedCopyWith<$Res>? get deedCompleted;

}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = freezed,Object? deedCompleted = freezed,Object? bypassUsed = null,Object? barakahEarned = null,}) {
  return _then(_Session(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,deedCompleted: freezed == deedCompleted ? _self.deedCompleted : deedCompleted // ignore: cast_nullable_to_non_nullable
as Deed?,bypassUsed: null == bypassUsed ? _self.bypassUsed : bypassUsed // ignore: cast_nullable_to_non_nullable
as bool,barakahEarned: null == barakahEarned ? _self.barakahEarned : barakahEarned // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeedCopyWith<$Res>? get deedCompleted {
    if (_self.deedCompleted == null) {
    return null;
  }

  return $DeedCopyWith<$Res>(_self.deedCompleted!, (value) {
    return _then(_self.copyWith(deedCompleted: value));
  });
}
}

// dart format on
