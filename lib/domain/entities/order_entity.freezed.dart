// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OrderEntity {
  String get id;
  int get seatingAreaId;
  int get productId;
  String get productName;
  double get productPrice;
  int get quantity;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $OrderEntityCopyWith<OrderEntity> get copyWith =>
      _$OrderEntityCopyWithImpl<OrderEntity>(this as OrderEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OrderEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seatingAreaId, seatingAreaId) ||
                other.seatingAreaId == seatingAreaId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, seatingAreaId, productId,
      productName, productPrice, quantity);

  @override
  String toString() {
    return 'OrderEntity(id: $id, seatingAreaId: $seatingAreaId, productId: $productId, productName: $productName, productPrice: $productPrice, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class $OrderEntityCopyWith<$Res> {
  factory $OrderEntityCopyWith(
          OrderEntity value, $Res Function(OrderEntity) _then) =
      _$OrderEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      int seatingAreaId,
      int productId,
      String productName,
      double productPrice,
      int quantity});
}

/// @nodoc
class _$OrderEntityCopyWithImpl<$Res> implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._self, this._then);

  final OrderEntity _self;
  final $Res Function(OrderEntity) _then;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? seatingAreaId = null,
    Object? productId = null,
    Object? productName = null,
    Object? productPrice = null,
    Object? quantity = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      seatingAreaId: null == seatingAreaId
          ? _self.seatingAreaId
          : seatingAreaId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productPrice: null == productPrice
          ? _self.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _OrderEntity extends OrderEntity {
  _OrderEntity(
      {this.id = '',
      required this.seatingAreaId,
      required this.productId,
      required this.productName,
      required this.productPrice,
      required this.quantity})
      : super._();

  @override
  @JsonKey()
  final String id;
  @override
  final int seatingAreaId;
  @override
  final int productId;
  @override
  final String productName;
  @override
  final double productPrice;
  @override
  final int quantity;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$OrderEntityCopyWith<_OrderEntity> get copyWith =>
      __$OrderEntityCopyWithImpl<_OrderEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OrderEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.seatingAreaId, seatingAreaId) ||
                other.seatingAreaId == seatingAreaId) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, seatingAreaId, productId,
      productName, productPrice, quantity);

  @override
  String toString() {
    return 'OrderEntity(id: $id, seatingAreaId: $seatingAreaId, productId: $productId, productName: $productName, productPrice: $productPrice, quantity: $quantity)';
  }
}

/// @nodoc
abstract mixin class _$OrderEntityCopyWith<$Res>
    implements $OrderEntityCopyWith<$Res> {
  factory _$OrderEntityCopyWith(
          _OrderEntity value, $Res Function(_OrderEntity) _then) =
      __$OrderEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      int seatingAreaId,
      int productId,
      String productName,
      double productPrice,
      int quantity});
}

/// @nodoc
class __$OrderEntityCopyWithImpl<$Res> implements _$OrderEntityCopyWith<$Res> {
  __$OrderEntityCopyWithImpl(this._self, this._then);

  final _OrderEntity _self;
  final $Res Function(_OrderEntity) _then;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? seatingAreaId = null,
    Object? productId = null,
    Object? productName = null,
    Object? productPrice = null,
    Object? quantity = null,
  }) {
    return _then(_OrderEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      seatingAreaId: null == seatingAreaId
          ? _self.seatingAreaId
          : seatingAreaId // ignore: cast_nullable_to_non_nullable
              as int,
      productId: null == productId
          ? _self.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _self.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productPrice: null == productPrice
          ? _self.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _self.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
