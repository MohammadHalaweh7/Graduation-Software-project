// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      json['result'] as Map<String, dynamic>,
    )
      ..id = json['_id'] as String
      ..name = json['name'] as String
      ..email = json['email'] as String
      ..description = json['description'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..detailedLocation = json['detailedLocation'] as String
      ..facebook = json['facebook'] as String
      ..snapchat = json['snapchat'] as String
      ..whatsapp = json['whatsapp'] as String
      ..instagram = json['instagram'] as String
      ..locationOnMap = json['locationOnMap'] as String
      ..location = json['location'] as String
      ..type = json['type'] as String
      ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'description': instance.description,
      'phoneNumber': instance.phoneNumber,
      'detailedLocation': instance.detailedLocation,
      'facebook': instance.facebook,
      'snapchat': instance.snapchat,
      'whatsapp': instance.whatsapp,
      'instagram': instance.instagram,
      'locationOnMap': instance.locationOnMap,
      'location': instance.location,
      'type': instance.type,
      'avatar': instance.avatar,
      'result': instance.result,
    };
