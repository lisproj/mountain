import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:mountain/components/providers/config_provider.dart';
import 'package:mountain/utils/config.dart';

class AdbSettings extends ConsumerWidget {
  const AdbSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(configProvider);
    final configNotifier = ref.read(configProvider.notifier);

    return Expander(
      header: Row(
        children: [
          const Icon(fi.FluentIcons.bot_20_regular),
          const SizedBox(width: 10),
          Text(FlutterI18n.translate(context, "settings.adb.title")),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(FlutterI18n.translate(context, "settings.adb.source")),
          const SizedBox(height: 5),
          ComboBox<String>(
            value: config.adbSource,
            items: [
              ComboBoxItem(
                value: "builtin",
                child: Text(FlutterI18n.translate(
                    context, "settings.adb.source_builtin")),
              ),
              ComboBoxItem(
                value: "custom",
                child: Text(FlutterI18n.translate(
                    context, "settings.adb.source_custom")),
              ),
              ComboBoxItem(
                value: "env",
                child: Text(
                    FlutterI18n.translate(context, "settings.adb.source_env")),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                configNotifier.updateAdbSource(value);
              }
            },
          ),
          const SizedBox(height: 10),
          if (config.adbSource == "custom")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(FlutterI18n.translate(context, "settings.adb.path")),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        placeholder: FlutterI18n.translate(
                            context, "settings.adb.path_placeholder"),
                        readOnly: true,
                        controller:
                            TextEditingController(text: config.adbPath ?? ""),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Button(
                      child: Text(FlutterI18n.translate(
                          context, "settings.adb.select_path")),
                      onPressed: () async {
                        final path = await ConfigUtil.pickDirectory();
                        if (path != null) {
                          configNotifier.updateAdbPath(path);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 10),
          Text(FlutterI18n.translate(context, "settings.adb.rule_source")),
          const SizedBox(height: 5),
          ComboBox<String>(
            value: config.ruleSource,
            items: [
              ComboBoxItem(
                value: "github",
                child: Text(FlutterI18n.translate(
                    context, "settings.adb.rule_source_github")),
              ),
              ComboBoxItem(
                value: "gitlab",
                child: Text(FlutterI18n.translate(
                    context, "settings.adb.rule_source_gitlab")),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                configNotifier.updateRuleSource(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
