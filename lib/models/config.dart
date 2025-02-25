import 'package:json_annotation/json_annotation.dart';
import 'dart:ui';

part 'config.g.dart';

@JsonSerializable()
class Config {
  String language;
  String theme;
  String material;

  String adbSource;
  String? adbPath;
  String ruleSource;

  Config(
      {required this.language,
      required this.theme,
      required this.material,
      required this.adbSource,
      this.adbPath,
      required this.ruleSource});

  /// Init Config with default values based on system settings
  static Config initialize() {
    // Get system locale for language
    final locale = PlatformDispatcher.instance.locale;
    final language = locale.languageCode;

    return Config(
      language: language,
      theme: 'system', // Follow system theme
      material: 'default', // Default material (flutter_acrylic)
      adbSource: 'builtin',
      ruleSource: 'github',
    );
  }

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  Map<String, dynamic> toJson() => _$ConfigToJson(this);
}
