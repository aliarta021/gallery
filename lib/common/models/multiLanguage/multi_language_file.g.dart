// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_language_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiLanguageFile _$MultiLanguageFileFromJson(Map<String, dynamic> json) =>
    MultiLanguageFile(
      fa: json['fa'] == null
          ? null
          : FileModel.fromJson(json['fa'] as Map<String, dynamic>),
      en: json['en'] == null
          ? null
          : FileModel.fromJson(json['en'] as Map<String, dynamic>),
      ar: json['ar'] == null
          ? null
          : FileModel.fromJson(json['ar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MultiLanguageFileToJson(MultiLanguageFile instance) =>
    <String, dynamic>{
      'fa': instance.fa,
      'en': instance.en,
      'ar': instance.ar,
    };
