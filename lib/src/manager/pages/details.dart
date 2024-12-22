import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../view_model/view_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  static const RouteName route = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('更多资料'),
        ),
        body: Center(
          child: Consumer<ManagerViewModel>(
            builder: (context, viewModel, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('引用插件'),
                Text(viewModel.pluginNames()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
