import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/view_model.dart';

class WindowMoveOverlay extends StatelessWidget {
  const WindowMoveOverlay({
    super.key,
    required this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) => ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: child,
          ),
        ),
        OverlayEntry(
          builder: (_) => SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: PreferredSize(
                preferredSize: const Size.fromHeight(
                  kToolbarHeight,
                ),
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Consumer<SystemViewModel>(
                    builder: (_, viewModel, child) => GestureDetector(
                      onDoubleTap: () => viewModel.maximizeWindow(),
                      onPanStart: (_) => viewModel.startDragging(),
                      behavior: HitTestBehavior.translucent,
                      child: child,
                    ),
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
