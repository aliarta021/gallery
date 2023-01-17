// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_language_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiLanguageTextAdapter extends TypeAdapter<MultiLanguageText> {
  @override
  final int typeId = 1;

  @override
  MultiLanguageText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiLanguageText(
      fa: fields[0] as String?,
      en: fields[1] as String?,
      ar: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MultiLanguageText obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.fa)
      ..writeByte(1)
      ..write(obj.en)
      ..writeByte(2)
      ..write(obj.ar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiLanguageTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiLanguageText _$MultiLanguageTextFromJson(Map<String, dynamic> json) =>
    MultiLanguageText(
      fa: json['fa'] as String?,
      en: json['en'] as String?,
      ar: json['ar'] as String?,
    );

Map<String, dynamic> _$MultiLanguageTextToJson(MultiLanguageText instance) =>
    <String, dynamic>{
      'fa': instance.fa,
      'en': instance.en,
      'ar': instance.ar,
    };
