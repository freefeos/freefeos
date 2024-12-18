import 'package:flutter/material.dart';
import 'package:freefeos/src/manager/common/values.dart';
import 'package:freefeos/src/manager/utils/utils.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import 'details.dart';
import 'index.dart';
import 'licenses.dart';
import 'manager.dart';
import 'settings.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  static const RouteName route = '/about';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('关于应用'),
        ),
        body: Column(
          children: [
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).popUntil(
                ModalRoute.withName(
                  IndexPage.route,
                ),
              ),
              child: Text('进入应用'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                DetailsPage.route,
              ),
              child: Text('更多资料'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                LicensesPage.route,
              ),
              child: Text('开放源代码许可'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                SettingsPage.route,
              ),
              child: Text('设置'),
            ),
            FilledButton(
              onPressed: AppUtils.getNavBoolValue(context, hideManager)
                  ? null
                  : () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(
                        ManagerPage.route,
                        arguments: AppUtils.setNavBoolValue({
                          hideManager: true,
                        }),
                      ),
              child: Text('管理器'),
            ),
          ],
        ),
      ),
    );
  }
}
