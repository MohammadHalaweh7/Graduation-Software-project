import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String name;
  late final String email;
  late final String description;
  late final String phoneNumber;
  late final String location;
  late final String type;
  late final String locationOnMap;
  Map result = {};
  // StoreModel();
  StoreModel(this.result);

  /// factory.
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
