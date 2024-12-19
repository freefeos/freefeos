import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../intl/app_localizations.dart';
import 'home.dart';
import 'logcat.dart';
import 'plugin.dart';
import 'settings.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  static const RouteName route = '/manager';

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  /// 当前页面
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: AdaptiveScaffold(
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: AppLocalizations.of(
              context,
            ).managerDestinationHome,
            tooltip: AppLocalizations.of(
              context,
            ).managerDestinationHome,
            enabled: true,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bug_report_outlined),
            selectedIcon: const Icon(Icons.bug_report),
            label: AppLocalizations.of(
              context,
            ).managerDestinationLog,
            tooltip: AppLocalizations.of(
              context,
            ).managerDestinationLog,
            enabled: true,
          ),
          NavigationDestination(
            icon: const Icon(Icons.extension_outlined),
            selectedIcon: const Icon(Icons.extension),
            label: AppLocalizations.of(
              context,
            ).managerDestinationPlugin,
            tooltip: AppLocalizations.of(
              context,
            ).managerDestinationPlugin,
            enabled: true,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: AppLocalizations.of(
              context,
            ).managerDestinationSetting,
            tooltip: AppLocalizations.of(
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
            const SettingsScreen(),
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
            AppLocalizations.of(
              context,
            ).managerTitle,
          ),
        ),
        appBarBreakpoint: Breakpoints.standard,
      ),
    );
  }
}
