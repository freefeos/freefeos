import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../view_model/view_model.dart';

class WindowControlButtons extends StatefulWidget {
  const WindowControlButtons({super.key});

  @override
  State<WindowControlButtons> createState() => _WindowControlButtonsState();
}

class _WindowControlButtonsState extends State<WindowControlButtons>
    with WindowListener {
  /// 最大化按钮的图标
  IconData _maxIcon = Icons.fullscreen;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMaximize() {
    super.onWindowMaximize();
    setState(() => _maxIcon = Icons.fullscreen_exit);
  }

  @override
  void onWindowUnmaximize() {
    super.onWindowUnmaximize();
    setState(() => _maxIcon = Icons.fullscreen);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => Container(
        height: 30,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black.withOpacity(0.3)
              : Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Tooltip(
                message: '最小化',
                child: InkWell(
                  onTap: viewModel.minimizeWindow,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      Icons.minimize,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                indent: 6,
                endIndent: 6,
                width: 1,
                color: Colors.white.withOpacity(0.3),
              ),
              Tooltip(
                message: '最大化',
                child: InkWell(
                  onTap: viewModel.maximizeWindow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      _maxIcon,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
              VerticalDivider(
                indent: 6,
                endIndent: 6,
                width: 1,
                color: Colors.white.withOpacity(0.3),
              ),
              Tooltip(
                message: '关闭窗口',
                child: InkWell(
                  onTap: viewModel.closeWindow,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 3,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
