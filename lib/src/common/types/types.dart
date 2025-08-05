part of '../common.dart';

/// 日志监听器
/// 框架使用
typedef LoggerListener = void Function(LoggerRecord record);

/// 视图模型
/// Shell ViewModel Base 使用
typedef ViewModel = ChangeNotifier;

/// 视图模型Provider
typedef ViewModelProvider<T extends ViewModel> = ChangeNotifierProvider<T>;

/// 路由名称
/// Shell 使用
typedef RouteName = String;

/// 页面构建器
typedef UiPageBuilder = UiPage Function(BuildContext context);

/// SDK调用器
typedef SdkInvoker = T? Function<T>(String apiId, [dynamic arguments]);

/// 系统能力
typedef OSAbility = OSViewModel;

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

typedef ExitCallback = void Function(VoidCallback exit);
