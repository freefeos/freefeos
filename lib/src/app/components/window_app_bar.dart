import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'menu_buttons.dart';
import 'window_control_buttons.dart';

class WindowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WindowAppBar({
    super.key,
    this.appBar,
    this.extern,
  });

  final AppBar? appBar;
  final bool? extern;

  /// 应用顶栏大小
  @override
  Size get preferredSize {
    return const Size.fromHeight(
      kToolbarHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (_) => Container(
            child: appBar,
          ),
        ),
        OverlayEntry(
          builder: (context) => SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: AppUtils.kIsDesktopWithUI(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: WindowControlButtons(),
                      ),
                    ),
                    Visibility(
                      visible: extern == true,
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
    // return Stack(
    //   children: <Positioned>[
    //     Positioned(
    //       left: 0,
    //       top: 0,
    //       right: 0,
    //       bottom: 0,
    //       child: ConstrainedBox(
    //         constraints: const BoxConstraints.expand(),
    //         child: appBar,
    //       ),
    //     ),

    //     /// TODO: 把拖动区域和窗口控制按钮封装分别放在每个页面实现与系统界面解藕
    //     Positioned(
    //       left: 0,
    //       top: MediaQuery.paddingOf(context).top,
    //       right: 0,
    //       height: kToolbarHeight,
    //       child: Consumer<SystemViewModel>(
    //         builder: (context, viewModel, child) => GestureDetector(
    //           onPanStart: (_) => viewModel.startDragging(),
    //           onDoubleTap: () => viewModel.maximizeWindow(),
    //           behavior: HitTestBehavior.translucent,
    //           child: ,
    //         ),),
    //     ),
    //   ],
    // );
  }
}
