import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:mountain/providers/config_provider.dart';

class AdbSettings extends ConsumerWidget {
  const AdbSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            value: ref.watch(adbSourcePrefProvider),
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
                ref.read(adbSourcePrefProvider.notifier).update(value);
              }
            },
          ),
          const SizedBox(height: 10),
          if (ref.watch(adbSourcePrefProvider) == "custom")
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
                        controller: TextEditingController(
                            text: ref.watch(adbPathPrefProvider) ?? ""),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Button(
                      child: Text(FlutterI18n.translate(
                          context, "settings.adb.select_path")),
                      onPressed: () async {
                        final result =
                            await FilePicker.platform.getDirectoryPath();
                        if (result != null) {
                          ref.read(adbPathPrefProvider.notifier).update(result);
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
            value: ref.watch(ruleSourcePrefProvider),
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
                ref.read(ruleSourcePrefProvider.notifier).update(value);
              }
            },
          ),
        ],
      ),
    );
  }
}
