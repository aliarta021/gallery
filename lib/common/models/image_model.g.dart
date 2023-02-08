// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      mobile: json['mobile'] == null
          ? null
          : MultiLanguageFile.fromJson(json['mobile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'mobile': instance.mobile,
    };
