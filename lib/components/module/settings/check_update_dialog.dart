import 'package:flutter/material.dart';

void showCheckUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const CheckUpdateDialog(),
  );
}

class CheckUpdateDialog extends StatefulWidget {
  const CheckUpdateDialog({super.key});

  @override
  State<CheckUpdateDialog> createState() => _CheckUpdateDialogState();
}

class _CheckUpdateDialogState extends State<CheckUpdateDialog> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // TODO: Real fetching
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isLoading ? '检查更新中' : '检查更新'),
      content: SizedBox(
        height: 100,
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : const Text('您当前已是最新版本'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('浏览更新日志'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('确认'),
        ),
      ],
    );
  }
}
