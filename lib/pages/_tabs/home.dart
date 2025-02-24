import 'package:fluent_ui/fluent_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('主页'),
      ),
      content: const Center(
        child: Text(
          '这是主页',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}