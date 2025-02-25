import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mountain/models/config.dart';
import 'package:mountain/utils/config.dart';

class ConfigNotifier extends StateNotifier<Config> {
  ConfigNotifier(Config config) : super(config);

  Future<void> updateConfig(Config newConfig) async {
    await ConfigUtil.saveConfig(newConfig);
    state = newConfig;
  }

  Future<void> updateLanguage(String language) async {
    final newConfig = state.copyWith(language: language);
    await updateConfig(newConfig);
  }

  Future<void> updateTheme(String theme) async {
    final newConfig = state.copyWith(theme: theme);
    await updateConfig(newConfig);
  }

  Future<void> updateMaterial(String material) async {
    final newConfig = state.copyWith(material: material);
    await updateConfig(newConfig);
  }

  Future<void> updateAdbSource(String adbSource) async {
    final newConfig = state.copyWith(adbSource: adbSource);
    await updateConfig(newConfig);
  }

  Future<void> updateAdbPath(String? adbPath) async {
    final newConfig = state.copyWith(adbPath: adbPath);
    await updateConfig(newConfig);
  }

  Future<void> updateRuleSource(String ruleSource) async {
    final newConfig = state.copyWith(ruleSource: ruleSource);
    await updateConfig(newConfig);
  }

  Future<void> reloadConfig() async {
    state = await ConfigUtil.loadConfig();
  }
}

final configProvider = StateNotifierProvider<ConfigNotifier, Config>((ref) {
  // This is a placeholder, the actual config will be loaded in main.dart
  return ConfigNotifier(Config.initialize());
});
