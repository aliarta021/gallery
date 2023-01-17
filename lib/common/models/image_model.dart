import 'package:json_annotation/json_annotation.dart';
import 'package:revolution1401/common/models/multiLanguage/multi_language_file.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  ImageModel({this.mobile});

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  final MultiLanguageFile? mobile;

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
