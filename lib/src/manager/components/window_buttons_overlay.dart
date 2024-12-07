import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'menu_buttons.dart';
import 'window_control_buttons.dart';

class WindowButtonsOverlay extends StatelessWidget {
  const WindowButtonsOverlay({
    super.key,
    this.isIndex = false,
    required this.child,
  });

  final bool isIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: child,
        ),
        SafeArea(
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
                    Visibility(
                      visible: AppUtils.kIsDesktopWithUI(context),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: WindowControlButtons(),
                      ),
                    ),
                    Visibility(
                      visible: isIndex == true,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: MenuButtons(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
