import 'dart:collection';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../components/dialog_button.dart';
import '../components/window_control_buttons.dart';
import '../event/event.dart';
import '../framework/ansi_parser.dart';
import '../framework/toast.dart';
import '../intl/package_localizations.dart';
import '../model/plugin_details.dart';
import '../type/types.dart';
import '../utils/utils.dart';
import '../values/route.dart';
import '../view_model/view_model.dart';

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
          return AppContainer();
        },
      ),
      routes: <String, WidgetBuilder>{
        routeManager: (_) => SystemManager(),
        routePlugin: (_) => PluginUI(),
      },
      builder: (context, child) {
        return SystemUIBuilder(
          builder: widget.builder,
          child: child,
        );
      },
      onGenerateTitle: (context) {
        return PackageLocalizations.of(
          context,
        ).packageName;
      },
      color: Colors.transparent,
      localizationsDelegates: PackageLocalizations.localizationsDelegates,
      supportedLocales: PackageLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppContainer extends StatefulWidget {
  const AppContainer({super.key});

  @override
  State<AppContainer> createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(
          builder: (context) => ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: PlatformUtil.kNoBanner
                ? AppRootView()
                : Banner(
                    message: PackageLocalizations.of(
                      context,
                    ).bannerTitle,
                    location: BannerLocation.topStart,
                    child: AppRootView(),
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
                        visible: WidgetUtil.kIsDesktopWithUI(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: WindowControlButtons(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                                        color: Theme.of(context).brightness ==
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
                                        color: Theme.of(context).brightness ==
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
  }
}

class AppRootView extends StatefulWidget {
  const AppRootView({super.key});

  @override
  State<AppRootView> createState() => _AppRootViewState();
}

class _AppRootViewState extends State<AppRootView>
    with AutomaticKeepAliveClientMixin {
  /// 启用状态保持
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => Container(
        child: viewModel.getChild,
      ),
    );
  }
}

class SystemUIBuilder extends StatelessWidget {
  const SystemUIBuilder({
    super.key,
    required this.child,
    required this.builder,
  });

  final Widget? child;
  final ViewModelBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Theme(
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
            final ViewModel viewModel = builder(context);
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
    );
  }
}

class SystemAbout extends StatelessWidget {
  const SystemAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => AlertDialog(
        title: ListTile(
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
          contentPadding: EdgeInsets.only(
            left: 24,
            top: 8,
            right: 24,
            bottom: 0,
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: Text(
          PackageLocalizations.of(
            context,
          ).aboutDialogLegalese,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(),
            child: Text('许可'),
          ),
          TextButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(),
            child: Text('取消'),
          ),
        ],
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
                  builder: (context) => SystemAbout(),
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

class SystemManager extends StatefulWidget {
  const SystemManager({super.key});

  @override
  State<SystemManager> createState() => _SystemManagerState();
}

class _SystemManagerState extends State<SystemManager> {
  /// 当前页面
  int _currentIndex = 0;

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
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 6,
                          ),
                          child: ListTile(
                            title: Text('随机一言'),
                            subtitle: Text(viewModel.getPoem),
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
                              useRootNavigator: true,
                              builder: (context) => SystemAbout(),
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
                  color: LogUtils.level2Color(
                    logEntry.level,
                    context,
                  ),
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
    _scrollController.dispose();
    super.dispose();
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
                              builder: (context) => SystemAbout(),
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 840,
            ),
            child: Consumer<SystemViewModel>(
              builder: (context, viewModel, child) => SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        right: 12,
                        top: 12,
                        bottom: 6,
                      ),
                      child: Card(
                        child: Column(
                          children: [
                            Tooltip(
                              message: '关于 FreeFEOS',
                              child: ListTile(
                                title: Text('关于'),
                                subtitle: Text('关于 FreeFEOS'),
                                leading: Icon(Icons.info_outline),
                                onTap: () => showDialog(
                                  context: context,
                                  useRootNavigator: true,
                                  builder: (context) => SystemAbout(),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  top: 6,
                                  left: 24,
                                  right: 24,
                                  bottom: 3,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            Tooltip(
                              message: '了解如何使用 FreeFEOS 进行开发',
                              child: ListTile(
                                title: Text('了解更多'),
                                subtitle: Text('了解如何使用 FreeFEOS 进行开发'),
                                leading: Icon(Icons.web),
                                onTap: () => viewModel.launchPubDev(),
                                contentPadding: const EdgeInsets.only(
                                  top: 3,
                                  left: 24,
                                  right: 24,
                                  bottom: 6,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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

class PluginUI extends StatelessWidget {
  const PluginUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 3,
                ),
                child: Icon(Icons.extension),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 3,
                ),
                child: Text(
                  viewModel.getCurrentDetails.title,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          actions: [
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
        body: viewModel.getPluginWidget(
          context,
          viewModel.getCurrentDetails,
        ),
      ),
    );
  }
}
