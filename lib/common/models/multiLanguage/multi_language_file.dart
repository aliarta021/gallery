import 'package:json_annotation/json_annotation.dart';
import 'package:revolution1401/common/file_model.dart';
import 'package:revolution1401/common/models/multiLanguage/multi_language.dart';

part 'multi_language_file.g.dart';

@JsonSerializable()
class MultiLanguageFile extends MultiLanguage<FileModel> with MultiLanguageMixin<FileModel> {
  MultiLanguageFile({this.fa, this.en, this.ar});

  factory MultiLanguageFile.fromJson(Map<String, dynamic> json) => _$MultiLanguageFileFromJson(json);

  @override
  FileModel? fa;
  @override
  FileModel? en;
  @override
  FileModel? ar;

  Map<String, dynamic> toJson() => _$MultiLanguageFileToJson(this);
}
