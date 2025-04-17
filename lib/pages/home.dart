import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mountain/components/module/cards/required_tips_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mountain'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context.go('/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RequiredTipsCard(
              title: '还有一步…',
              message:
                  '我们需要借助 Shizuku 以在 Android 设备上执行卸载、禁用等高阶 ADB 操作，请前往安装并激活 Shizuku 来使用高阶功能。',
              onIgnore: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("该通知将转移并仅在设置页面显示"),
                  ),
                );
              },
              onInstall: () =>
                  launchUrl(Uri.parse("https://shizuku.rikka.app")),
            ),
          ],
        ),
      ),
    );
  }
}
