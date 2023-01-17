import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:revolution1401/common/models/multiLanguage/multi_language_text.dart';

enum SliderContentType {
  @JsonValue('saleableItemService')
  saleableItemService,
  @JsonValue('shop')
  shop,
  @JsonValue('banner')
  banner,
}

enum SliderRenderType {
  @JsonValue('simple')
  simple,
  @JsonValue('grid')
  grid,
  @JsonValue('multiple')
  multiple,
}

abstract class SliderModel {
  MultiLanguageText? title;
  MultiLanguageText? subtitle;
  SliderContentType? contentType;
  SliderRenderType? renderType;
  int? height;
  double? aspectRatio;
  bool? infiniteScroll = true;
  bool? autoPlay = true;
  List<String>? items;
  GestureDetector? onTap;
}
