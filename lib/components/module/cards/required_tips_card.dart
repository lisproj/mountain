import 'package:flutter/material.dart';

class RequiredTipsCard extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onIgnore;
  final VoidCallback onInstall;

  const RequiredTipsCard({
    super.key,
    required this.title,
    required this.message,
    required this.onIgnore,
    required this.onInstall,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.blue,
                  size: 24,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(message),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onIgnore,
                  child: const Text('忽略'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: onInstall,
                  child: const Text('了解更多'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
