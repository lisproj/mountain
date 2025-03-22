import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:system_theme/system_theme.dart';

import 'package:mountain/pages/_routes.dart';
import 'package:mountain/providers/config_provider.dart';

Future<void> main() async {
  await SystemTheme.accentColor.load();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  if (!Platform.isAndroid) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = WindowOptions(
      title: "Mountain",
      size: const Size(1200, 800),
      minimumSize: const Size(1000, 600),
      center: true,
      skipTaskbar: false,
      windowButtonVisibility: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(ProviderScope(child: const App()));
}

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    ThemeMode theme;
    if (ref.watch(themePrefProvider) == "light") {
      theme = ThemeMode.light;
    } else if (ref.watch(themePrefProvider) == "dark") {
      theme = ThemeMode.dark;
    } else if (ref.watch(themePrefProvider) == "system") {
      theme = ThemeMode.system;
    } else {
      theme = ThemeMode.system;
    }

    Locale locale;
    if (ref.watch(languagePrefProvider) == "system") {
      locale = Locale(PlatformDispatcher.instance.locale.languageCode);
    } else {
      locale = Locale(ref.watch(languagePrefProvider) ?? 'en');
    }

    final lightTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: ref.watch(dynamicColorPrefProvider) == true
            ? SystemTheme.accentColor.accent
            : Colors.tealAccent,
      ),
    );

    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ref.watch(dynamicColorPrefProvider) == true
            ? SystemTheme.accentColor.accent
            : Colors.tealAccent,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor:
          ref.watch(oledDarkModePrefProvider) == true ? Colors.black : null,
      canvasColor:
          ref.watch(oledDarkModePrefProvider) == true ? Colors.black : null,
    );

    return MaterialApp.router(
      title: 'Mountain',
      debugShowCheckedModeBanner: false,
      themeMode: theme,
      theme: lightTheme,
      darkTheme: darkTheme,
      supportedLocales: const [
        Locale('en', "US"), // English (US)
        Locale('zh', 'CN'), // Simplified Chinese (PRC)
      ],
      localizationsDelegates: [
        FlutterI18nDelegate(
            translationLoader: FileTranslationLoader(
                useCountryCode: true,
                fallbackFile: "en",
                basePath: "assets/i18n",
                decodeStrategies: [YamlDecodeStrategy()])),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: locale,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
