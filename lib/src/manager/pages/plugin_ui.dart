import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/window_buttons_overlay.dart';
import '../view_model/view_model.dart';

class PluginUiPage extends StatelessWidget {
  const PluginUiPage({super.key});

  static const String route = '/plugin_ui';

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Consumer<ManagerViewModel>(
        builder: (context, viewModel, _) => Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 3,
                  ),
                  child: Icon(Icons.extension),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 3,
                  ),
                  child: Text(
                    viewModel.getCurrentDetails.title,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          body: viewModel.getPluginWidget(
            context,
            viewModel.getCurrentDetails,
          ),
        ),
      ),
    );
  }
}
