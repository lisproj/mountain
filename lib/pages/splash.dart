import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // TODO: real loading function
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/tabs');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProgressRing(),
            SizedBox(height: 20),
            Text('正在加载...', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
