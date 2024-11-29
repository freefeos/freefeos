import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/view_model.dart';

class WindowMoveArea extends StatelessWidget {
  const WindowMoveArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, child) => GestureDetector(
        onPanStart: (_) => viewModel.startDragging(),
        onDoubleTap: () => viewModel.maximizeWindow(),
        behavior: HitTestBehavior.translucent,
      ),
    );
  }
}
