import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  // ignore: unused_field

  @JsonKey(name: '_id')
  late final String id;
  late final String title;
  late final String description;
  late final String? avatar;
  NotificationModel();

  /// factory.
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
