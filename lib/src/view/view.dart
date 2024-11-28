import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../components/dialog_button.dart';
import '../intl/package_localizations.dart';
import '../pages/index.dart';
import '../pages/manager.dart';
import '../pages/plugin_ui.dart';
import '../type/types.dart';
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
          return IndexPage();
        },
      ),
      routes: <String, WidgetBuilder>{
        routeManager: (_) => ManagerPage(),
        routePlugin: (_) => PluginUiPage(),
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
            onPressed: () {

              showLicensePage(context: context);
            },
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
