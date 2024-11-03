import 'dart:collection';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:window_manager/window_manager.dart';

import '../event/event_buffer.dart';
import '../event/rendered_event.dart';
import '../framework/ansi_parser.dart';
import '../framework/log.dart';
import '../framework/toast.dart';
import '../intl/package_localizations.dart';
import '../plugin/plugin_details.dart';
import '../type/types.dart';
import '../utils/utils.dart';
import '../values/route.dart';
import '../mvvm/mmvm.dart';

/// 系统界面布局
class SystemUI extends StatefulWidget {
  const SystemUI({
    super.key,
    required this.builder,
  });

  final ViewModelBuilder builder;

  @override
  State<SystemUI> createState() => _SystemUIState();
}

class _SystemUIState extends State<SystemUI> {
  /// 当前页面
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      pageRouteBuilder: <T>(
        RouteSettings settings,
        WidgetBuilder builder,
      ) {
        return MaterialPageRoute<T>(
          builder: builder,
          settings: settings,
        );
      },
      home: Consumer<SystemViewModel>(
        builder: (context, viewModel, _) {
          viewModel.attachBuildContext(context);
          return Overlay(
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (context) => ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: PlatformUtil.kNoBanner
                      ? Container(
                          child: viewModel.getChild,
                        )
                      : Banner(
                          message: PackageLocalizations.of(
                            context,
                          ).bannerTitle,
                          location: BannerLocation.topStart,
                          child: viewModel.getChild,
                        ),
                ),
              ),
              OverlayEntry(
                builder: (context) => Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.paddingOf(context).top,
                      right: MediaQuery.paddingOf(context).right,
                      left: MediaQuery.paddingOf(context).left,
                    ),
                    child: SizedBox(
                      height: kToolbarHeight,
                      child: PreferredSize(
                        preferredSize: const Size.fromHeight(
                          kToolbarHeight,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Visibility(
                              visible: PlatformUtil.kIsDesktop,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: WindowPanel(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Tooltip(
                                        message: '系统菜单',
                                        child: InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            useRootNavigator: true,
                                            builder: (_) => const SystemDialog(
                                              isManager: false,
                                            ),
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 3,
                                            ),
                                            child: Icon(
                                              Icons.more_horiz,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      VerticalDivider(
                                        indent: 6,
                                        endIndent: 6,
                                        width: 1,
                                        color: Colors.white.withOpacity(0.3),
                                      ),
                                      Tooltip(
                                        message: '退出应用',
                                        child: InkWell(
                                          onTap: () => showDialog(
                                            context: context,
                                            useRootNavigator: true,
                                            builder: (_) => const SystemExit(),
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 3,
                                            ),
                                            child: Icon(
                                              Icons.adjust,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      routes: <String, WidgetBuilder>{
        routeManager: (context) {
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
            selectedIndex: _currentIndex,
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
              ][_currentIndex],
            ),
            transitionDuration: const Duration(
              milliseconds: 500,
            ),
            onSelectedIndexChange: (index) => setState(
              () => _currentIndex = index,
            ),
            useDrawer: false,
            appBar: AppBar(
              title: Text(
                PackageLocalizations.of(
                  context,
                ).managerTitle,
              ),
              actions: [
                Tooltip(
                  message: PackageLocalizations.of(
                    context,
                  ).bottomSheetTooltip,
                  child: IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      useRootNavigator: true,
                      builder: (_) => const SystemDialog(
                        isManager: true,
                      ),
                    ),
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
                Visibility(
                  visible: PlatformUtil.kIsDesktop,
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 12,
                    ),
                    child: WindowPanel(),
                  ),
                ),
              ],
            ),
            appBarBreakpoint: Breakpoints.standard,
          );
        },
        routePlugin: (_) {
          return Consumer<SystemViewModel>(
            builder: (context, viewModel, _) => Scaffold(
              appBar: AppBar(
                title: Text(
                  viewModel.getCurrentDetails.title,
                ),
                actions: [
                  Visibility(
                    visible: PlatformUtil.kIsDesktop,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 12,
                      ),
                      child: WindowPanel(),
                    ),
                  ),
                ],
              ),
              body: viewModel.getPluginWidget(
                context,
                viewModel.getCurrentDetails,
              ),
            ),
          );
        },
      },
      builder: (context, child) => Theme(
        data: ThemeData(
          useMaterial3: true,
          brightness: MediaQuery.platformBrightnessOf(
            context,
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: MediaQuery.platformBrightnessOf(
              context,
            ),
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
              TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.linux: ZoomPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.windows: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        child: ToastificationWrapper(
          child: ChangeNotifierProvider<SystemViewModel>(
            create: (context) {
              final ViewModel viewModel = widget.builder(context);
              assert(() {
                if (viewModel is! SystemViewModel) {
                  throw FlutterError(
                    PackageLocalizations.of(
                      context,
                    ).viewModelTypeError,
                  );
                }
                return true;
              }());
              return viewModel as SystemViewModel;
            },
            child: Consumer<SystemViewModel>(
              builder: (context, viewModel, child) => Stack(
                children: <Positioned>[
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: child,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: MediaQuery.paddingOf(context).top,
                    right: 0,
                    height: kToolbarHeight,
                    child: PreferredSize(
                      preferredSize: const Size.fromHeight(
                        kToolbarHeight,
                      ),
                      child: GestureDetector(
                        onPanStart: (_) => viewModel.startDragging(),
                        onDoubleTap: () => viewModel.maximizeWindow(),
                        behavior: HitTestBehavior.translucent,
                      ),
                    ),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
      onGenerateTitle: (context) {
        return PackageLocalizations.of(context).packageName;
      },
      color: Colors.transparent,
      localizationsDelegates: PackageLocalizations.localizationsDelegates,
      supportedLocales: PackageLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// 关于对话框布局
class SystemAbout extends StatelessWidget {
  const SystemAbout({
    super.key,
    required this.isPackage,
  });

  final bool isPackage;

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, child) {
        return FutureBuilder(
          future: viewModel.getAppName(),
          builder: (context, snapshot) {
            String appName = PackageLocalizations.of(
              context,
            ).unknown;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                appName = PackageLocalizations.of(
                  context,
                ).waiting;
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  appName = PackageLocalizations.of(
                    context,
                  ).error;
                  break;
                }
                if (snapshot.hasData) {
                  appName = snapshot.data ??
                      PackageLocalizations.of(
                        context,
                      ).sNull;
                  break;
                }
                break;
              default:
                break;
            }
            return FutureBuilder(
              future: viewModel.getAppVersion(),
              builder: (context, snapshot) {
                String appVersion = PackageLocalizations.of(
                  context,
                ).unknown;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    appVersion = PackageLocalizations.of(
                      context,
                    ).waiting;
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      appVersion = PackageLocalizations.of(
                        context,
                      ).error;
                      break;
                    }
                    if (snapshot.hasData) {
                      appVersion = snapshot.data ??
                          PackageLocalizations.of(
                            context,
                          ).sNull;
                      break;
                    }
                    break;
                  default:
                    break;
                }
                return AboutDialog(
                  applicationName: isPackage
                      ? PackageLocalizations.of(
                          context,
                        ).aboutPackageName
                      : appName,
                  applicationVersion: appVersion,
                  applicationLegalese: isPackage
                      ? PackageLocalizations.of(
                          context,
                        ).aboutPackageDescription
                      : PackageLocalizations.of(
                          context,
                        ).aboutDialogLegalese,
                  children: WidgetUtil.widget2WidgetList(child),
                );
              },
            );
          },
        );
      },
    );
  }
}

class WindowPanel extends StatefulWidget {
  const WindowPanel({super.key});

  @override
  State<WindowPanel> createState() => _WindowPanelState();
}

class _WindowPanelState extends State<WindowPanel> with WindowListener {
  /// 最大化按钮的图标
  IconData _maxIcon = Icons.fullscreen;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    super.onWindowMaximize();
    setState(() => _maxIcon = Icons.fullscreen_exit);
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowUnmaximize();
    setState(() => _maxIcon = Icons.fullscreen);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => Container(
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Tooltip(
                message: '最小化',
                child: InkWell(
                  onTap: viewModel.minimizeWindow,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      Icons.minimize,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                indent: 6,
                endIndent: 6,
                width: 1,
                color: Colors.white.withOpacity(0.3),
              ),
              Tooltip(
                message: '最大化',
                child: InkWell(
                  onTap: viewModel.maximizeWindow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      _maxIcon,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                indent: 6,
                endIndent: 6,
                width: 1,
                color: Colors.white.withOpacity(0.3),
              ),
              Tooltip(
                message: '关闭窗口',
                child: InkWell(
                  onTap: viewModel.closeWindow,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 系统菜单
class SystemDialog extends StatelessWidget {
  const SystemDialog({
    super.key,
    required this.isManager,
  });

  final bool isManager;

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => AlertDialog(
        title: Tooltip(
          message: '打开管理器',
          child: ListTile(
            leading: Opacity(
              opacity: isManager ? 0.5 : 1,
              child: FlutterLogo(),
            ),
            title: FutureBuilder(
              future: viewModel.getAppName(),
              builder: (context, snapshot) {
                String text = PackageLocalizations.of(
                  context,
                ).unknown;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    text = PackageLocalizations.of(
                      context,
                    ).waiting;
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      text = PackageLocalizations.of(
                        context,
                      ).error;
                      break;
                    }
                    if (snapshot.hasData) {
                      text = snapshot.data ??
                          PackageLocalizations.of(
                            context,
                          ).sNull;
                      break;
                    }
                    break;
                  default:
                    break;
                }
                return Text(text);
              },
            ),
            subtitle: FutureBuilder(
              future: viewModel.getAppVersion(),
              builder: (context, snapshot) {
                String text = PackageLocalizations.of(
                  context,
                ).unknown;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    text = PackageLocalizations.of(
                      context,
                    ).waiting;
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      text = PackageLocalizations.of(
                        context,
                      ).error;
                      break;
                    }
                    if (snapshot.hasData) {
                      text = snapshot.data ??
                          PackageLocalizations.of(
                            context,
                          ).sNull;
                      break;
                    }
                    break;
                  default:
                    break;
                }
                return Text(text);
              },
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 24,
              top: 8,
              right: 24,
              bottom: 0,
            ),
            enabled: !isManager,
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop();
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(routeManager);
            },
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: Wrap(
          alignment: WrapAlignment.center,
          children: <DialogButton>[
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamed(routeManager);
              },
              icon: Icons.manage_accounts_outlined,
              label: PackageLocalizations.of(
                context,
              ).bottomSheetManager,
              tooltip: PackageLocalizations.of(
                context,
              ).bottomSheetManagerTooltip,
              enabled: !isManager,
            ),
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => const SystemAbout(
                    isPackage: false,
                  ),
                );
              },
              icon: Icons.info_outline,
              label: '关于',
              tooltip: '关于',
              enabled: true,
            ),
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => const SystemExit(),
                );
              },
              icon: Icons.exit_to_app,
              label: PackageLocalizations.of(
                context,
              ).bottomSheetExit,
              tooltip: PackageLocalizations.of(
                context,
              ).bottomSheetExitToolTip,
              enabled: true,
            ),
          ],
        ),
        actions: <Widget>[
          Tooltip(
            message: '关闭对话框',
            child: TextButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop(),
              child: Text('取消'),
            ),
          )
        ],
      ),
    );
  }
}

/// 系统菜单按钮
class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.enabled,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final String tooltip;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: tooltip,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              child: InkWell(
                onTap: enabled ? onTap : null,
                canRequestFocus: enabled,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Center(
                    child: Opacity(
                      opacity: enabled ? 1 : 0.5,
                      child: Icon(
                        icon,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Opacity(
              opacity: enabled ? 1 : 0.5,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 退出对话框布局
class SystemExit extends StatelessWidget {
  const SystemExit({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, child) => AlertDialog(
        title: Text(
          PackageLocalizations.of(
            context,
          ).closeDialogTitle,
        ),
        content: Text(
          PackageLocalizations.of(
            context,
          ).closeDialogMessage,
        ),
        actions: [
          Tooltip(
            message: PackageLocalizations.of(
              context,
            ).closeDialogCancelButton,
            child: TextButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop(),
              child: Text(
                PackageLocalizations.of(
                  context,
                ).closeDialogCancelButton,
              ),
            ),
          ),
          Tooltip(
            message: PackageLocalizations.of(
              context,
            ).closeDialogExitButton,
            child: TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                viewModel.exitApp();
              },
              child: Text(
                PackageLocalizations.of(
                  context,
                ).closeDialogExitButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 主页页面布局
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: false,
      minimum: EdgeInsets.zero,
      maintainBottomViewPadding: true,
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 840),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: Consumer<SystemViewModel>(
                builder: (context, viewModel, child) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                      child: Tooltip(
                        message: '打开应用',
                        child: Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: InkWell(
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).popUntil(
                              ModalRoute.withName(routeRoot),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              child: ListTile(
                                leading: const FlutterLogo(),
                                title: FutureBuilder(
                                  future: viewModel.getAppName(),
                                  builder: (context, snapshot) {
                                    String text = PackageLocalizations.of(
                                      context,
                                    ).unknown;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        text = PackageLocalizations.of(
                                          context,
                                        ).waiting;
                                        break;
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          text = PackageLocalizations.of(
                                            context,
                                          ).error;
                                          break;
                                        }
                                        if (snapshot.hasData) {
                                          text = snapshot.data ??
                                              PackageLocalizations.of(
                                                context,
                                              ).sNull;
                                          break;
                                        }
                                        break;
                                      default:
                                        break;
                                    }
                                    return Text(text);
                                  },
                                ),
                                subtitle: FutureBuilder(
                                  future: viewModel.getAppVersion(),
                                  builder: (context, snapshot) {
                                    String text = PackageLocalizations.of(
                                      context,
                                    ).unknown;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        text = PackageLocalizations.of(
                                          context,
                                        ).waiting;
                                        break;
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          text = PackageLocalizations.of(
                                            context,
                                          ).error;
                                          break;
                                        }
                                        if (snapshot.hasData) {
                                          text = snapshot.data ??
                                              PackageLocalizations.of(
                                                context,
                                              ).sNull;
                                          break;
                                        }
                                        break;
                                      default:
                                        break;
                                    }
                                    return Text(text);
                                  },
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: Tooltip(
                        message: '关于',
                        child: Card(
                          child: InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) => SystemAbout(
                                isPackage: false,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      PackageLocalizations.of(
                                        context,
                                      ).managerHomeInfoAppName,
                                    ),
                                    subtitle: FutureBuilder(
                                      future: viewModel.getAppName(),
                                      builder: (context, snapshot) {
                                        String text = PackageLocalizations.of(
                                          context,
                                        ).unknown;
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            text = PackageLocalizations.of(
                                              context,
                                            ).waiting;
                                            break;
                                          case ConnectionState.done:
                                            if (snapshot.hasError) {
                                              text = PackageLocalizations.of(
                                                context,
                                              ).error;
                                              break;
                                            }
                                            if (snapshot.hasData) {
                                              text = snapshot.data ??
                                                  PackageLocalizations.of(
                                                    context,
                                                  ).sNull;
                                              break;
                                            }
                                            break;
                                          default:
                                            break;
                                        }
                                        return Text(text);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      PackageLocalizations.of(
                                        context,
                                      ).managerHomeInfoAppVersion,
                                    ),
                                    subtitle: FutureBuilder(
                                      future: viewModel.getAppVersion(),
                                      builder: (context, snapshot) {
                                        String text = PackageLocalizations.of(
                                          context,
                                        ).unknown;
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            text = PackageLocalizations.of(
                                              context,
                                            ).waiting;
                                            break;
                                          case ConnectionState.done:
                                            if (snapshot.hasError) {
                                              text = PackageLocalizations.of(
                                                context,
                                              ).error;
                                              break;
                                            }
                                            if (snapshot.hasData) {
                                              text = snapshot.data ??
                                                  PackageLocalizations.of(
                                                    context,
                                                  ).sNull;
                                              break;
                                            }
                                            break;
                                          default:
                                            break;
                                        }
                                        return Text(text);
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      PackageLocalizations.of(
                                        context,
                                      ).managerHomeInfoPlatform,
                                    ),
                                    subtitle: Text(
                                      Theme.of(context).platform.name,
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      PackageLocalizations.of(
                                        context,
                                      ).managerHomeInfoPluginCount,
                                    ),
                                    subtitle: Text(
                                      viewModel.pluginCount(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      child: Tooltip(
                        message: PackageLocalizations.of(
                          context,
                        ).managerHomeLearnTooltip,
                        child: Card(
                          child: InkWell(
                            onTap: viewModel.launchPubDev,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              child: ListTile(
                                title: Text(
                                  PackageLocalizations.of(
                                    context,
                                  ).managerHomeLearnTitle,
                                ),
                                subtitle: Text(
                                  PackageLocalizations.of(
                                    context,
                                  ).managerHomeLearnDescription,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 日志页面布局
class LogcatPage extends StatefulWidget {
  const LogcatPage({super.key});

  @override
  State<LogcatPage> createState() => _LogcatPageState();
}

class _LogcatPageState extends State<LogcatPage> {
  final ListQueue<RenderedEvent> _renderedBuffer = ListQueue();
  final ScrollController _scrollController = ScrollController();
  final StringBuffer _logs = StringBuffer('Start: ');
  List<RenderedEvent> _filteredBuffer = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _renderedBuffer.clear();
    for (var event in EventBuffer.outputEventBuffer) {
      final IAnsiParser parser = AnsiParser(
        context: context,
        showTips: () => Toast.makeToast(
          context: context,
          text: PackageLocalizations.of(
            context,
          ).managerLogCopyTips,
        ).show(),
      );
      final String text = event.lines.join('\n');
      int currentId = 0;
      parser.parse(text);
      _renderedBuffer.add(
        RenderedEvent(
          currentId++,
          event.level,
          TextSpan(children: parser.getSpans),
          text.toLowerCase(),
        ),
      );
    }
    setState(
      () => _filteredBuffer = _renderedBuffer.where(
        (it) {
          if (it.level.value < Level.CONFIG.value) {
            return false;
          } else {
            return true;
          }
        },
      ).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logs.clear();
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: false,
      minimum: EdgeInsets.zero,
      maintainBottomViewPadding: true,
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          controller: _scrollController,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: _filteredBuffer.length,
            itemBuilder: (context, index) {
              final RenderedEvent logEntry = _filteredBuffer[index];
              _logs.write("${logEntry.lowerCaseText}\n");
              return Text.rich(
                logEntry.span,
                key: Key(logEntry.id.toString()),
                style: TextStyle(
                  fontSize: 14,
                  color: logEntry.level.toColor(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 插件页面布局
class PluginPage extends StatefulWidget {
  const PluginPage({super.key});

  @override
  State<PluginPage> createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: false,
      minimum: EdgeInsets.zero,
      maintainBottomViewPadding: true,
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 840,
            ),
            child: Consumer<SystemViewModel>(
              builder: (context, viewModel, child) => ListView.builder(
                controller: _scrollController,
                itemCount: viewModel.getPluginDetailsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  // 首项
                  final PluginDetails first =
                      viewModel.getPluginDetailsList.first;
                  // 尾项
                  final PluginDetails last =
                      viewModel.getPluginDetailsList.last;
                  // 项
                  final PluginDetails details =
                      viewModel.getPluginDetailsList[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      top: first == details ? 12 : 6,
                      bottom: last == details ? 12 : 6,
                      left: 12,
                      right: 12,
                    ),
                    child: Card(
                      child: Tooltip(
                        message: viewModel.getPluginTooltip(context, details),
                        child: InkWell(
                          onTap: () => viewModel.clickPlugin(
                            context,
                            details,
                            () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(routePlugin),
                            () => showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => const SystemAbout(
                                isPackage: true,
                              ),
                            ),
                            () => showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('无界面'),
                                  content: Text('此插件未提供用户界面.'),
                                  actions: [
                                    Tooltip(
                                      message: '确定',
                                      child: TextButton(
                                        onPressed: () => Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(),
                                        child: Text('确定'),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                            child: Consumer<SystemViewModel>(
                              builder: (context, viewModel, child) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              details.title,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .titleMedium
                                                    ?.fontSize,
                                                fontFamily: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .titleMedium
                                                    ?.fontFamily,
                                                height: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.height,
                                                fontWeight: FontWeight.bold,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              '${PackageLocalizations.of(context).managerPluginChannel}: ${details.channel}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.fontSize,
                                                fontFamily: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .bodySmall
                                                    ?.fontFamily,
                                                height: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.height,
                                              ),
                                            ),
                                            Text(
                                              '${PackageLocalizations.of(context).managerPluginAuthor}: ${details.author}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.fontSize,
                                                fontFamily: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .bodySmall
                                                    ?.fontFamily,
                                                height: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.height,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: viewModel.getPluginIcon(
                                          context,
                                          details,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    details.description,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.apply(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    maxLines: 4,
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          viewModel.getPluginType(
                                            context,
                                            details,
                                          ),
                                          textAlign: TextAlign.start,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodySmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 设置页面布局
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: false,
      minimum: EdgeInsets.zero,
      maintainBottomViewPadding: true,
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
