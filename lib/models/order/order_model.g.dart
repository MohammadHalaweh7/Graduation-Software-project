// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel()
  ..id = json['_id'] as String
  ..buyerName = json['buyerName'] as String
  ..buyerEmail = json['buyerEmail'] as String
  ..buyerPhone = json['buyerPhone'] as String
  ..buyerCity = json['buyerCity'] as String
  ..buyerAddress = json['buyerAddress'] as String
  ..orderNumber = json['orderNumber'] as String
  ..storeName = json['storeName'] as String
  ..productName = json['productName'] as String
  ..price = json['price'] as String
  ..orderStatus = json['orderStatus'] as String
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'buyerName': instance.buyerName,
      'buyerEmail': instance.buyerEmail,
      'buyerPhone': instance.buyerPhone,
      'buyerCity': instance.buyerCity,
      'buyerAddress': instance.buyerAddress,
      'orderNumber': instance.orderNumber,
      'storeName': instance.storeName,
      'productName': instance.productName,
      'price': instance.price,
      'orderStatus': instance.orderStatus,
      'avatar': instance.avatar,
    };
