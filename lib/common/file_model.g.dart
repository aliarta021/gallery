// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      meta: json['meta'] == null
          ? null
          : FileMeta.fromJson(json['meta'] as Map<String, dynamic>),
      hashKey: json['hashKey'] as String?,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'meta': instance.meta,
      'hashKey': instance.hashKey,
    };

FileMeta _$FileMetaFromJson(Map<String, dynamic> json) => FileMeta(
      size: json['size'] as int?,
    );

Map<String, dynamic> _$FileMetaToJson(FileMeta instance) => <String, dynamic>{
      'size': instance.size,
    };
