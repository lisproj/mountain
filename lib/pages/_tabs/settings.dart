import 'package:card_settings_ui/card_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mountain/components/layout/navbar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:mountain/components/module/settings/check_update_dialog.dart';
import 'package:mountain/providers/config_provider.dart';
import 'package:mountain/types/preference.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String _version = '';
  final String _year = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "settings.title")),
      ),
      body: SizedBox(
        width: (MediaQuery.of(context).size.width > 1000) ? 1000 : null,
        child: _settings(),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget _settings() {
    return SettingsList(
      sections: [
        SettingsSection(
          title:
              Text(FlutterI18n.translate(context, "settings.appearance.title")),
          tiles: [
            SettingsTile.navigation(
              leading: Icon(Icons.language_rounded),
              title: Text(
                  FlutterI18n.translate(context, "settings.language.title")),
              value: Text(
                  languageOptions[ref.watch(languagePrefProvider)] ?? '未知'),
              onPressed: (_) {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 100, 100),
                  items: [
                    ...languageOptions.entries.map((entry) {
                      return PopupMenuItem(
                        value: entry.key,
                        onTap: () {
                          ref
                              .read(languagePrefProvider.notifier)
                              .update(entry.key);
                        },
                        child: Text(entry.value),
                      );
                    }),
                  ],
                );
              },
            ),
            SettingsTile.navigation(
              leading: Icon(Icons.dark_mode_rounded),
              title: Text('主题'),
              description: Text('切换深浅色主题'),
              value: Text(themeOptions[ref.watch(themePrefProvider)] ?? '未知'),
              onPressed: (_) {
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 100, 100),
                  items: [
                    ...themeOptions.entries.map((entry) {
                      return PopupMenuItem(
                        value: entry.key,
                        onTap: () {
                          ref
                              .read(themePrefProvider.notifier)
                              .update(entry.key);
                        },
                        child: Text(entry.value),
                      );
                    }),
                  ],
                  elevation: 8.0,
                );
              },
            ),
            SettingsTile.switchTile(
              leading: Icon(Icons.contrast_rounded),
              onToggle: (value) async {
                ref
                    .read(oledDarkModePrefProvider.notifier)
                    .update(!(ref.watch(oledDarkModePrefProvider)));
              },
              title: Text('OLED 深色显示优化'),
              description: Text('将深色模式中的背景替换为纯黑色'),
              initialValue: ref.watch(oledDarkModePrefProvider),
            ),
            SettingsTile.switchTile(
              leading: Icon(Icons.palette_rounded),
              onToggle: (value) async {
                ref
                    .read(dynamicColorPrefProvider.notifier)
                    .update(!(ref.watch(dynamicColorPrefProvider)));
              },
              title: Text('动态色调'),
              description: Text('根据系统设定自动切换配色'),
              initialValue: ref.watch(dynamicColorPrefProvider),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('关于'),
          bottomInfo: Text('© $_year Li. All rights reserved.'),
          tiles: [
            SettingsTile.navigation(
              onPressed: (_) {
                launchUrl(Uri.parse("https://github.com/lisproj/connect"),
                    mode: LaunchMode.externalApplication);
              },
              leading: Icon(Icons.code_rounded),
              title: Text('源代码存储库'),
              value: Text('前往 GitHub'),
            ),
            SettingsTile.navigation(
              onPressed: (_) {
                showLicensePage(
                  context: context,
                  applicationVersion: _version,
                  applicationLegalese: '© $_year Li. All rights reserved.',
                );
              },
              leading: Icon(Icons.military_tech_rounded),
              title: Text('开放源代码许可证'),
              description: Text('客户端所使用的开源许可证声明'),
            ),
            SettingsTile.navigation(
              onPressed: (_) {
                showCheckUpdateDialog(context);
              },
              leading: Icon(Icons.info_rounded),
              title: Text('当前版本'),
              description: Text('轻触以检查更新'),
              value: Text(_version),
            ),
          ],
        ),
      ],
    );
  }
}
