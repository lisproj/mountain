import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:mountain/providers/config_provider.dart';

class LanguageSettings extends ConsumerWidget {
  const LanguageSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Map of language codes to both native name and translated name
    final languageOptions = {
      'en': {
        'native': 'English',
        'translated': FlutterI18n.translate(context, "settings.language.en_us")
      },
      'zh': {
        'native': '简体中文 (中国)',
        'translated': FlutterI18n.translate(context, "settings.language.zh_cn")
      },
    };

    return Expander(
      header: Row(
        children: [
          const Icon(fi.FluentIcons.translate_20_regular),
          const SizedBox(width: 10),
          Text(FlutterI18n.translate(context, "settings.language.title")),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(FlutterI18n.translate(context, "settings.language.select")),
          const SizedBox(height: 5),
          ListView.builder(
            shrinkWrap: true,
            itemCount: languageOptions.length,
            itemBuilder: (context, index) {
              final languageCode = languageOptions.keys.elementAt(index);
              final language = languageOptions[languageCode]!;

              return RadioButton(
                checked: ref.watch(languagePrefProvider) == languageCode,
                onChanged: (checked) {
                  if (checked) {
                    ref
                        .read(languagePrefProvider.notifier)
                        .update(languageCode);
                  }
                },
                content: Text('${language['native']}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
