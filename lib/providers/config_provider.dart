import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_riverpod/shared_preferences_riverpod.dart';

late SharedPreferences prefs;

final languagePrefProvider = createPrefProvider<String>(
  prefKey: 'language',
  defaultValue: 'system',
  prefs: (_) => prefs,
);

final themePrefProvider = createPrefProvider<String>(
  prefKey: 'theme',
  defaultValue: 'system',
  prefs: (_) => prefs,
);

final oledDarkModePrefProvider = createPrefProvider<bool>(
  prefKey: 'oled_dark_mode',
  defaultValue: false,
  prefs: (_) => prefs,
);

final dynamicColorPrefProvider = createPrefProvider<bool>(
  prefKey: 'dynamic_color',
  defaultValue: false,
  prefs: (_) => prefs,
);

final materialPrefProvider = createPrefProvider<String>(
  prefKey: 'material',
  defaultValue: 'default',
  prefs: (_) => prefs,
);

final adbSourcePrefProvider = createPrefProvider<String>(
  prefKey: 'adb_source',
  defaultValue: 'builtin',
  prefs: (_) => prefs,
);

final adbPathPrefProvider = createPrefProvider<String?>(
  prefKey: 'adb_path',
  defaultValue: null,
  prefs: (_) => prefs,
);

final ruleSourcePrefProvider = createPrefProvider<String>(
  prefKey: 'rule_source',
  defaultValue: 'github',
  prefs: (_) => prefs,
);
