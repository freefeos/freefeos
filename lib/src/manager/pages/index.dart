import 'package:flutter/material.dart';
import 'package:freefeos/src/common/types/types.dart';
import 'package:provider/provider.dart';

import '../components/app_banner.dart';
import '../components/app_root_view.dart';
import '../components/window_buttons_overlay.dart';
import '../view_model/view_model.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  static const RouteName route = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) {
        viewModel.attachBuildContext(context);
        return Container(child: child);
      },
      child: WindowButtonsOverlay(
        isIndex: true,
        child: AppBanner(
          child: AppRootView(),
        ),
      ),
    );
  }
}
