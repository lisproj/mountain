import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutSettings extends ConsumerStatefulWidget {
  const AboutSettings({super.key});

  @override
  ConsumerState<AboutSettings> createState() => _AboutSettingsState();
}

class _AboutSettingsState extends ConsumerState<AboutSettings> {
  String _version = '';
  bool _checkingUpdate = false;

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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _checkForUpdates() async {
    setState(() {
      _checkingUpdate = true;
    });

    // TODO: real fetch update
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _checkingUpdate = false;
    });

    // Show a dialog indicating the update status
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: Text(FlutterI18n.translate(
              context, "settings.about.update_check_result")),
          content:
              Text(FlutterI18n.translate(context, "settings.about.up_to_date")),
          actions: [
            Button(
              child: Text(FlutterI18n.translate(context, "common.ok")),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expander(
      header: Row(
        children: [
          const Icon(fi.FluentIcons.info_20_regular),
          const SizedBox(width: 10),
          Text(FlutterI18n.translate(context, "settings.about.title")),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoLabel(
            label: FlutterI18n.translate(context, "settings.about.version"),
            child: Text("Mountain $_version"),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Button(
                onPressed: _checkingUpdate ? null : _checkForUpdates,
                child: _checkingUpdate
                    ? const ProgressRing(strokeWidth: 2)
                    : Text(FlutterI18n.translate(
                        context, "settings.about.check_updates")),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(FlutterI18n.translate(context, "settings.about.links_title")),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Button(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(fi.FluentIcons.code_20_regular),
                    const SizedBox(width: 8),
                    Text(FlutterI18n.translate(
                        context, "settings.about.github")),
                  ],
                ),
                onPressed: () =>
                    _launchUrl("https://github.com/lisproj/mountain"),
              ),
              Button(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(fi.FluentIcons.globe_20_regular),
                    const SizedBox(width: 8),
                    Text(FlutterI18n.translate(
                        context, "settings.about.website")),
                  ],
                ),
                onPressed: () =>
                    _launchUrl("https://lisproj.github.io/mountain/"),
              ),
              // Button(
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       const Icon(fi.FluentIcons.money_hand_20_regular),
              //       const SizedBox(width: 8),
              //       Text(FlutterI18n.translate(
              //           context, "settings.about.donate")),
              //     ],
              //   ),
              //   onPressed: () =>
              //       _launchUrl("https://www.buymeacoffee.com/mountain"),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
