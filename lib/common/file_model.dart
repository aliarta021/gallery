import 'package:json_annotation/json_annotation.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  FileModel({this.id, this.type, this.meta, this.hashKey});

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);

  final String? id;
  final String? type;
  final FileMeta? meta;
  final String? hashKey;

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}

@JsonSerializable()
class FileMeta {
  FileMeta({this.size});

  factory FileMeta.fromJson(Map<String, dynamic> json) => _$FileMetaFromJson(json);

  final int? size;

  Map<String, dynamic> toJson() => _$FileMetaToJson(this);
}
