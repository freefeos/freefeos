import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../common/types/types.dart';
import '../sdk/option.dart';
import 'components/window_move_area.dart';
import 'intl/app_localizations.dart';
import 'pages/index.dart';
import 'pages/manager.dart';
import 'pages/plugin_ui.dart';
import 'view_model/view_model.dart';

class Manager extends StatelessWidget implements IAppOption {
  const Manager({super.key, required this.builder});

  final ViewModelBuilder builder;

  /// 页面
  @override
  Map<String, WidgetBuilder> pages() {
    return {
      IndexPage.route: (_) => IndexPage(),
      ManagerPage.route: (_) => ManagerPage(),
      PluginUiPage.route: (_) => PluginUiPage(),
    };
  }

  @override
  ThemeData style(BuildContext context) {
    return ThemeData(
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
    );
  }

  @override
  String title(BuildContext context) {
    return AppLocalizations.of(context).packageName;
  }

  @override
  void onError() {}

  @override
  void onHide() {}

  @override
  void onLaunch() {}

  @override
  void onPageNotFound() {}

  @override
  void onShow() {}

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
      routes: pages(),
      builder: (context, child) {
        return Theme(
          data: style(context),
          child: ToastificationWrapper(
            child: ChangeNotifierProvider<SystemViewModel>(
              create: (context) {
                final ViewModel viewModel = builder(context);
                assert(() {
                  if (viewModel is! SystemViewModel) {
                    throw FlutterError(
                      AppLocalizations.of(
                        context,
                      ).viewModelTypeError,
                    );
                  }
                  return true;
                }());
                return viewModel as SystemViewModel;
              },
              child: WindowMoveOverlay(
                child: child,
              ),
            ),
          ),
        );
      },
      onGenerateTitle: title,
      color: Colors.transparent,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}
