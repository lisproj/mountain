// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      language: json['language'] as String,
      theme: json['theme'] as String,
      material: json['material'] as String,
      adbSource: json['adbSource'] as String,
      adbPath: json['adbPath'] as String?,
      ruleSource: json['ruleSource'] as String,
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'language': instance.language,
      'theme': instance.theme,
      'material': instance.material,
      'adbSource': instance.adbSource,
      'adbPath': instance.adbPath,
      'ruleSource': instance.ruleSource,
    };
