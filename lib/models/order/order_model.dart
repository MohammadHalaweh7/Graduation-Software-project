import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String buyerName;
  late final String buyerEmail;
  late final String buyerPhone;
  late final String buyerCity;
  late final String buyerAddress;
  late final String orderNumber;
  late final String storeName;
  late final String productName;
  late final String price;
  late final String orderStatus;

  OrderModel();

  /// factory.
  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
