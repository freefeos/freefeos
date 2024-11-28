import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/window_control_buttons.dart';
import '../utils/utils.dart';
import '../view_model/view_model.dart';

class PluginUiPage extends StatelessWidget {
  const PluginUiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
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
          actions: [
            Visibility(
              visible: WidgetUtil.kIsDesktopWithUI(context),
              child: const Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 12,
                ),
                child: WindowControlButtons(),
              ),
            ),
          ],
        ),
        body: viewModel.getPluginWidget(
          context,
          viewModel.getCurrentDetails,
        ),
      ),
    );
  }
}
