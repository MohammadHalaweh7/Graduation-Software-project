// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PendingPhotos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingPhotosModel _$PendingPhotosModelFromJson(Map<String, dynamic> json) =>
    PendingPhotosModel()
      ..id = json['_id'] as String
      ..email = json['email'] as String
      ..storename = json['storename'] as String
      ..photo = json['photo'] as String?;

Map<String, dynamic> _$PendingPhotosModelToJson(PendingPhotosModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'storename': instance.storename,
      'photo': instance.photo,
    };
