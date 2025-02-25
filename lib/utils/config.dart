import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:mountain/models/config.dart';

class ConfigUtil {
  static Future<String> get _configPath async {
    final configDir = await getApplicationSupportDirectory();
    if (!await configDir.exists()) {
      await configDir.create(recursive: true);
    }
    return path.join(configDir.path, 'mountain.appconf');
  }

  static Future<Config> loadConfig() async {
    try {
      final file = File(await _configPath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        return Config.fromJson(json.decode(contents));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading config: $e');
      }
    }
    return Config.initialize();
  }

  static Future<void> saveConfig(Config config) async {
    try {
      final file = File(await _configPath);

      await file.writeAsString(json.encode(config.toJson()));
    } catch (e) {
      if (kDebugMode) {
        print('Error saving config: $e');
      }
    }
  }

  static Future<String?> pickDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      return result;
    }
    return null;
  }
}
