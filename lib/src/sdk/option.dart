import 'package:flutter/material.dart';

abstract interface class IAppOption {
  /// 页面
  Map<String, WidgetBuilder> pages();
  Widget index(BuildContext context);
  ThemeData style(BuildContext context);
  String title(BuildContext context);
  PreferredSize moveArea(BuildContext context);

  /// TODO: ViewModule
  void onLaunch();
  void onShow();
  void onHide();
  void onError();
  void onPageNotFound();
}
