import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:revolution1401/common/models/image_model.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  BannerModel({this.name, this.description, this.image,});

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  final String? name;
  final String? description;
  final ImageModel? image;

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

  
}
