// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['_id'] as String
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..avatar = json['avatar'] as String?
  ..points = json['points'] as int;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'points': instance.points,
    };
