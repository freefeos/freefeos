import 'package:flutter/material.dart';

import '../components/window_buttons_overlay.dart';
import 'details.dart';
import 'index.dart';
import 'licenses.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  static const String route = '/info';

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
          ],
        ),
      ),
    );
  }
}
