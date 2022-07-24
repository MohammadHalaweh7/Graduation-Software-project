import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String name;
  late final String description;
  late double price;
  late final String owner;
  late final String? avatar;
  ProductModel();

  /// factory.
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
