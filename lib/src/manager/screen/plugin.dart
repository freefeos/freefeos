import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/plugin_card.dart';
import '../components/screen_adapter.dart';
import '../utils/utils.dart';
import '../values/values.dart';
import '../view_model/view_model.dart';

/// 插件页面布局
class PluginScreen extends StatefulWidget {
  const PluginScreen({super.key});

  @override
  State<PluginScreen> createState() => _PluginScreenState();
}

class _PluginScreenState extends State<PluginScreen> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenAdapter(
      child: Scrollbar(
        controller: _scrollController,
        child: Consumer<ManagerViewModel>(
          builder: (_, viewModel, __) => ListView.builder(
            controller: _scrollController,
            itemCount: viewModel.getPluginDetailsList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return PluginCard(
                details: viewModel.getPluginDetailsList[index],
                margin: EdgeInsets.only(
                  top: viewModel.getPluginDetailsList.first ==
                          viewModel.getPluginDetailsList[index]
                      ? 16
                      : 8,
                  bottom: viewModel.getPluginDetailsList.last ==
                          viewModel.getPluginDetailsList[index]
                      ? 16
                      : 8,
                  left: 16,
                  right: 16,
                ),
                enableAbout: !AppUtils.getNavBoolValue(
                  context,
                  hideManager,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
