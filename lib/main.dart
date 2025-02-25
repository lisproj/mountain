import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/yaml_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mountain/pages/_routes.dart';
import 'package:window_manager/window_manager.dart';
import 'package:mountain/utils/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mountain/components/providers/config_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  // Load config
  final config = await ConfigUtil.loadConfig();

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

  runApp(
    ProviderScope(
      overrides: [configProvider.overrideWith((ref) => ConfigNotifier(config))],
      child: const App(),
    ),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);

    // Determine brightness based on config theme
    Brightness brightness = Brightness.light;
    if (config.theme == 'dark') {
      brightness = Brightness.dark;
    } else if (config.theme == 'system') {
      // Use system theme
      final platformBrightness = MediaQuery.platformBrightnessOf(context);
      brightness = platformBrightness;
    }

    return FluentApp.router(
      title: 'Mountain',
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        brightness: brightness,
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
        // Locale('zh', 'TW'), // 正體中文 (臺灣) Traditional Chinese (Taiwan)
        // Locale('lzh') // 文言 (華夏) Classical Chinese (China)
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
      locale: Locale(config.language),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
