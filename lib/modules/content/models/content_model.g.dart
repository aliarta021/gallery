// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentModel _$ContentModelFromJson(Map<String, dynamic> json) => ContentModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      grouping: json['grouping'] as List<int>?,
      deathDate: json['death_date'] as int?,
      arrestDate: json['arrest_date'] as int?,
      freedomDate: json['freedom_date'] as int?,
    )..artist = json['artist'] as String?;

Map<String, dynamic> _$ContentModelToJson(ContentModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'grouping': instance.grouping,
      'death_date': instance.deathDate,
      'arrest_date': instance.arrestDate,
      'freedom_date': instance.freedomDate,
      'artist': instance.artist,
    };
