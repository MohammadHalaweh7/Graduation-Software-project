// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel()
  ..id = json['_id'] as String
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..avatar = json['avatar'] as String?
  ..NotificationFromPendingStore = json['NotificationFromPendingStore'] as bool;

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'NotificationFromPendingStore': instance.NotificationFromPendingStore,
    };
