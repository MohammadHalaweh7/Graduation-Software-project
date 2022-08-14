import 'package:json_annotation/json_annotation.dart';

part 'PendingPhotos_model.g.dart';

@JsonSerializable()
class PendingPhotosModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String email;
  late final String storename;
  late final String? photo;
  PendingPhotosModel();

  /// factory.
  factory PendingPhotosModel.fromJson(Map<String, dynamic> json) =>
      _$PendingPhotosModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PendingPhotosModelToJson(this);
}
