import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:mountain/providers/config_provider.dart';

class AppearanceSettings extends ConsumerWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expander(
      header: Row(
        children: [
          const Icon(fi.FluentIcons.dark_theme_20_regular),
          const SizedBox(width: 10),
          Text(FlutterI18n.translate(context, "settings.appearance.title")),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(FlutterI18n.translate(context, "settings.appearance.theme")),
          const SizedBox(height: 5),
          ComboBox<String>(
            value: ref.watch(themePrefProvider),
            items: [
              ComboBoxItem(
                value: "system",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.theme_system")),
              ),
              ComboBoxItem(
                value: "light",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.theme_light")),
              ),
              ComboBoxItem(
                value: "dark",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.theme_dark")),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(themePrefProvider.notifier).update(value);
              }
            },
          ),
          const SizedBox(height: 10),
          Text(FlutterI18n.translate(context, "settings.appearance.material")),
          const SizedBox(height: 5),
          ComboBox<String>(
            value: ref.watch(materialPrefProvider),
            items: [
              ComboBoxItem(
                value: "default",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.material_default")),
              ),
              ComboBoxItem(
                value: "acrylic",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.material_acrylic")),
              ),
              ComboBoxItem(
                value: "mica",
                child: Text(FlutterI18n.translate(
                    context, "settings.appearance.material_mica")),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                ref.read(materialPrefProvider.notifier).update(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
