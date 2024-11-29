import 'package:flutter/material.dart';

abstract interface class IAppOption {
  /// 页面
  Map<String, WidgetBuilder> pages();
  void onLaunch();
  void onShow();
  void onHide();
  void onError();
  void onPageNotFound();
}
