import 'package:flutter/material.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../screen/setting.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const RouteName route = '/setting';

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('设置'),
        ),
        body: SettingScreen(
          isManager: false,
        ),
      ),
    );
  }
}
