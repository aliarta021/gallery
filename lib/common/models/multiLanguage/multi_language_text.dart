import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:revolution1401/common/constants/hive_id.dart';

import 'multi_language.dart';

part 'multi_language_text.g.dart';

@HiveType(typeId: HiveId.multiLanguageText)
@JsonSerializable()
class MultiLanguageText extends MultiLanguage<String> with MultiLanguageMixin<String> {
  MultiLanguageText({this.fa, this.en, this.ar});

  factory MultiLanguageText.fromJson(Map<String, dynamic> json) => _$MultiLanguageTextFromJson(json);

  @HiveField(0)
  @override
  String? fa;
  @HiveField(1)
  @override
  String? en;
  @HiveField(2)
  @override
  String? ar;

  Map<String, dynamic> toJson() => _$MultiLanguageTextToJson(this);
}
