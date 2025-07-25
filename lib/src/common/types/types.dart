part of '../common.dart';

/// 上下文附加器
/// ViewModel使用
typedef ContextAttacher = void Function(BuildContext context);

/// 日志监听器
/// 框架使用
typedef LoggerListener = void Function(LoggerRecord record);

/// 视图模型
/// Shell ViewModel Base 使用
typedef ViewModel = ChangeNotifier;

/// 视图模型Provider
typedef ViewModelProvider<T extends ViewModel> = ChangeNotifierProvider<T>;

/// 视图模型构建器
/// Shell ViewModel Base 使用
typedef ViewModelBuilder = ViewModel Function(BuildContext context);

/// 路由名称
/// Shell 使用
typedef RouteName = String;

/// 页面构建器
typedef UiPageBuilder = UiPage Function(BuildContext context);

/// SDK调用器
typedef SdkInvoker = T? Function<T>(String apiId, [dynamic arguments]);

/// 系统能力
typedef OSAbility = OSViewModel;

/// 计算器执行计算回调
typedef CalculatorExecCallback = void Function(CalculatorButtonContent content);

/// Shell构建器
typedef ShellBuilder =
    Widget Function(
      BuildContext context,
      AppBarTheme appBarTheme,
      ThemeMode themeMode,
      NavigatorObserver navigatorObserver,
    );

/// 日志复制回调
typedef LogcatCopyCallback = void Function(String text);

/// 屏幕构建器
typedef UiScreenBuilder = UiScreen Function(BuildContext context);

typedef DetailDialogLauncher =
    void Function(
      BuildContext content,
      String title,
      String id,
      IconData icon,
      String description,
    );
typedef ModuleItemBuilder =
    Widget Function(
      BuildContext content,
      VoidCallback onTap,
      String title,
      IconData icon,
      bool isTop,
      bool isBottom,
    );
