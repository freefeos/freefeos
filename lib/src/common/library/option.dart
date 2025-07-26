part of '../common.dart';

/// 应用选项接口
abstract interface class IAppOption {
  /// 页面
  Map<RouteName, UiPageBuilder> get buildPages;

  /// 样式
  ThemeData buildStyle(BuildContext context);

  /// 标题
  String buildTitle(BuildContext context);

  /// ViewModel
  ViewModel get buildViewModel;
}
