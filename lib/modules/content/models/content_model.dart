import 'package:json_annotation/json_annotation.dart';

part 'content_model.g.dart';

@JsonSerializable()
class ContentModel {
  ContentModel({
    this.title,
    this.description,
    this.imageUrl,
    this.grouping,
    this.deathDate,
    this.arrestDate,
    this.freedomDate,
    this.artist,
    this.id,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) =>
      _$ContentModelFromJson(json);
  String? title;
  int? id = DateTime.now().millisecondsSinceEpoch;
  String? description;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  List<int>? grouping;
  @JsonKey(name: 'death_date')
  int? deathDate;
  @JsonKey(name: 'arrest_date')
  int? arrestDate;
  @JsonKey(name: 'freedom_date')
  int? freedomDate;
  String? artist;

  Map<String, dynamic> toJson() => _$ContentModelToJson(this);
}
