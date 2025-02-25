import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mountain/components/module/settings/about.dart';
import 'package:mountain/components/module/settings/adb.dart';
import 'package:mountain/components/module/settings/appearance.dart';
import 'package:mountain/components/module/settings/language.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(FlutterI18n.translate(context, "settings.title")),
      ),
      content: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          AppearanceSettings(),
          SizedBox(height: 10),
          LanguageSettings(),
          SizedBox(height: 10),
          AdbSettings(),
          SizedBox(height: 10),
          AboutSettings(),
        ],
      ),
    );
  }
}
