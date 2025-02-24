import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:mountain/pages/_tabs/home.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as fi;

class NavigationSidebar extends StatefulWidget {
  const NavigationSidebar({super.key});

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar> {
  int _selectedIndex = 0;

  Widget _title(BuildContext context) {
    return const DragToMoveArea(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Mountain", style: TextStyle(fontSize: 14))));
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        // leading: null,
        // automaticallyImplyLeading: false,
        title: _title(context),
        actions: const WindowActions(),
      ),
      pane: NavigationPane(
        selected: _selectedIndex,
        onChanged: (index) => setState(() => _selectedIndex = index),
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(fi.FluentIcons.home_32_regular),
            title: const Text('主页'),
            body: const HomePage(),
          ),
        ],
      ),
    );
  }
}

class WindowActions extends StatelessWidget {
  const WindowActions({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      SizedBox(
        width: 138,
        height: 50,
        child: WindowCaption(
          brightness: theme.brightness,
          backgroundColor: Colors.transparent,
        ),
      ),
    ]);
  }
}
