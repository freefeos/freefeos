import 'package:flutter/material.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../screen/setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  /// 页面路由地址
  static const RouteName route = '/setting';

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('设置'), // 设置页面标题
        ), // 顶部应用栏
        body: SettingScreen(
          isManager: false,
        ), // 设置屏幕
      ), // 页面脚手架
    ); // 窗口控制按钮叠加层
  }
}
