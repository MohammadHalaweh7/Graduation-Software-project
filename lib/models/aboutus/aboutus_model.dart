import 'package:json_annotation/json_annotation.dart';

part 'aboutus_model.g.dart';

@JsonSerializable()
class AboutUsModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String aboutUsDescription;
  late final String aboutStoreDescription;
  late final String makeUsSpecial;
  late final String phoneNumber;
  late final String facebook;
  late final String snapChat;
  late final String instagram;
  late final String whatsapp;
  late final String? avatar;

  AboutUsModel();

  /// factory.
  factory AboutUsModel.fromJson(Map<String, dynamic> json) =>
      _$AboutUsModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AboutUsModelToJson(this);
}
