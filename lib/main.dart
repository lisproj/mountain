import 'dart:io';
import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

import 'package:mountain/pages/_routes.dart';
import 'package:mountain/providers/config_provider.dart';

Future<void> main() async {
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
    ThemeMode themeMode;
    if (ref.watch(themePrefProvider) == "system") {
      themeMode = ThemeMode.system;
    } else if (ref.watch(themePrefProvider) == "dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }

    Locale locale;
    if (ref.watch(languagePrefProvider) == "system") {
      locale = Locale(PlatformDispatcher.instance.locale.languageCode);
    } else {
      locale = Locale(ref.watch(languagePrefProvider) ?? 'en');
    }

    return FluentApp.router(
      title: 'Mountain',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: FluentThemeData(
        brightness:
            themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
        visualDensity: VisualDensity.standard,
        accentColor: Colors.teal,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
        accentColor: Colors.teal,
        focusTheme:
            FocusThemeData(glowFactor: is10footScreen(context) ? 2.0 : 0.0),
      ),
      supportedLocales: const [
        Locale('en', "US"), // English (US)
        Locale('zh', 'CN'), // 简体中文 (中国) Simplified Chinese (PRC)
      ],
      localizationsDelegates: [
        FluentLocalizations.delegate,
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
