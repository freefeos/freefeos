import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

import '../intl/package_localizations.dart';
import '../app/pages/index.dart';
import '../app/pages/manager.dart';
import '../app/pages/plugin_ui.dart';
import '../type/types.dart';
import '../app/route.dart';
import '../app/view_model/view_model.dart';

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
