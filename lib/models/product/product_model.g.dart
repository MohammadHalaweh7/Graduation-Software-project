// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel()
  ..id = json['_id'] as String
  ..name = json['name'] as String
  ..description = json['description'] as String
  ..price = json['price'] as String
  ..owner = json['owner'] as String
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'owner': instance.owner,
      'avatar': instance.avatar,
    };
