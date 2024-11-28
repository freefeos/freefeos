import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import '../components/window_control_buttons.dart';
import '../intl/package_localizations.dart';
import '../utils/utils.dart';
import 'home.dart';
import 'logcat.dart';
import 'plugin.dart';
import 'settings.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  /// 当前页面
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      destinations: <NavigationDestination>[
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: PackageLocalizations.of(
            context,
          ).managerDestinationHome,
          tooltip: PackageLocalizations.of(
            context,
          ).managerDestinationHome,
          enabled: true,
        ),
        NavigationDestination(
          icon: const Icon(Icons.bug_report_outlined),
          selectedIcon: const Icon(Icons.bug_report),
          label: PackageLocalizations.of(
            context,
          ).managerDestinationLog,
          tooltip: PackageLocalizations.of(
            context,
          ).managerDestinationLog,
          enabled: true,
        ),
        NavigationDestination(
          icon: const Icon(Icons.extension_outlined),
          selectedIcon: const Icon(Icons.extension),
          label: PackageLocalizations.of(
            context,
          ).managerDestinationPlugin,
          tooltip: PackageLocalizations.of(
            context,
          ).managerDestinationPlugin,
          enabled: true,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: PackageLocalizations.of(
            context,
          ).managerDestinationSetting,
          tooltip: PackageLocalizations.of(
            context,
          ).managerDestinationSetting,
          enabled: true,
        ),
      ],
      smallBreakpoint: const Breakpoint(
        endWidth: 600,
      ),
      mediumBreakpoint: const Breakpoint(
        beginWidth: 600,
        endWidth: 840,
      ),
      largeBreakpoint: const Breakpoint(
        beginWidth: 840,
      ),
      selectedIndex: _currentPage,
      body: (_) => PageTransitionSwitcher(
        duration: const Duration(
          milliseconds: 300,
        ),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            child: child,
          );
        },
        child: <Widget>[
          const HomePage(),
          const LogcatPage(),
          const PluginPage(),
          const SettingsPage(),
        ][_currentPage],
      ),
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      onSelectedIndexChange: (index) => setState(
        () => _currentPage = index,
      ),
      useDrawer: false,
      appBar: AppBar(
        title: Text(
          PackageLocalizations.of(
            context,
          ).managerTitle,
        ),
        actions: [
          // Tooltip(
          //   message: PackageLocalizations.of(
          //     context,
          //   ).bottomSheetTooltip,
          //   child: IconButton(
          //     onPressed: () => showDialog(
          //       context: context,
          //       useRootNavigator: true,
          //       builder: (_) => const SystemDialog(
          //         isManager: true,
          //       ),
          //     ),
          //     icon: const Icon(Icons.more_vert),
          //   ),
          // ),
          Visibility(
            visible: WidgetUtil.kIsDesktopWithUI(context),
            child: const Padding(
              padding: EdgeInsets.only(
                left: 8,
                right: 12,
              ),
              child: WindowControlButtons(),
            ),
          ),
        ],
      ),
      appBarBreakpoint: Breakpoints.standard,
    );
  }
}
