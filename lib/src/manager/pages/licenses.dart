import 'package:flutter/material.dart';

import '../components/window_control_buttons.dart';
import '../utils/utils.dart';

class LicensesPage extends StatefulWidget {
  const LicensesPage({super.key});

  static const String route = 'licenses';

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => LicensePage(),
        ),
        OverlayEntry(
          builder: (context) => SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: kToolbarHeight,
                child: PreferredSize(
                  preferredSize: const Size.fromHeight(
                    kToolbarHeight,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Visibility(
                          visible: AppUtils.kIsDesktopWithUI(context),
                          child: WindowControlButtons(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
