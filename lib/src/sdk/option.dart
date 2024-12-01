import 'package:flutter/material.dart';

abstract interface class IAppOption {
  /// 页面
  Map<String, WidgetBuilder> pages();
  ThemeData style(BuildContext context);
  String title(BuildContext context);

  /// TODO: ViewModule
  /// ViewModel buildViewModel();
  void onLaunch();
  void onShow();
  void onHide();
  void onError();
  void onPageNotFound();
}
