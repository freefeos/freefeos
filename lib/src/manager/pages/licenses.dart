import 'package:flutter/material.dart';

import '../components/window_button_overlay.dart';

class LicensesPage extends StatefulWidget {
  const LicensesPage({super.key});

  static const String route = 'licenses';

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  @override
  Widget build(BuildContext context) {
    return WindowButtonOverlay(
      child: LicensePage(),
    );
  }
}
