import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_banner.dart';
import '../components/app_root_view.dart';
import '../components/window_button_overlay.dart';
import '../view_model/view_model.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  static const String route = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, child) {
        viewModel.attachBuildContext(context);
        return Container(child: child);
      },
      child: WindowButtonOverlay(
        isIndex: true,
        child: AppBanner(
          child: AppRootView(),
        ),
      ),
      // child: Overlay(
      //   initialEntries: <OverlayEntry>[
      //     OverlayEntry(
      //       builder: (_) => ConstrainedBox(
      //         constraints: const BoxConstraints.expand(),
      //         child: AppBanner(
      //           child: AppRootView(),
      //         ),
      //       ),
      //     ),
      //     OverlayEntry(
      //       builder: (_) => SafeArea(
      //         child: Align(
      //           alignment: Alignment.topCenter,
      //           child: SizedBox(
      //             height: kToolbarHeight,
      //             child: PreferredSize(
      //               preferredSize: const Size.fromHeight(
      //                 kToolbarHeight,
      //               ),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.max,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(right: 12),
      //                     child: Visibility(
      //                       visible: AppUtils.kIsDesktopWithUI(context),
      //                       child: WindowControlButtons(),
      //                     ),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(right: 12),
      //                     child: MenuButtons(),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
