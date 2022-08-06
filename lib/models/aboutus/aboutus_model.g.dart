// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aboutus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsModel _$AboutUsModelFromJson(Map<String, dynamic> json) => AboutUsModel()
  ..id = json['_id'] as String
  ..aboutUsDescription = json['aboutUsDescription'] as String
  ..aboutStoreDescription = json['aboutStoreDescription'] as String
  ..makeUsSpecial = json['makeUsSpecial'] as String
  ..phoneNumber = json['phoneNumber'] as String
  ..facebook = json['facebook'] as String
  ..snapChat = json['snapChat'] as String
  ..instagram = json['instagram'] as String
  ..whatsapp = json['whatsapp'] as String
  ..avatar = json['avatar'] as String?;

Map<String, dynamic> _$AboutUsModelToJson(AboutUsModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'aboutUsDescription': instance.aboutUsDescription,
      'aboutStoreDescription': instance.aboutStoreDescription,
      'makeUsSpecial': instance.makeUsSpecial,
      'phoneNumber': instance.phoneNumber,
      'facebook': instance.facebook,
      'snapChat': instance.snapChat,
      'instagram': instance.instagram,
      'whatsapp': instance.whatsapp,
      'avatar': instance.avatar,
    };
