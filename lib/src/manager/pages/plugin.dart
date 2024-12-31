import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../view_model/view_model.dart';

/// 插件页面
class PluginPage extends StatelessWidget {
  const PluginPage({super.key});

  /// 页面路由地址
  static const RouteName route = '/plugin';

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Consumer<ManagerViewModel>(
        builder: (context, viewModel, _) => Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min, // 最小
              crossAxisAlignment: CrossAxisAlignment.center, // 水平轴居中对齐
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 3,
                  ),
                  child: const Icon(Icons.extension), // 插件表示图标
                ), // 向右3个单位填充
                Padding(
                  padding: const EdgeInsets.only(
                    left: 3,
                  ),
                  child: Text(
                    viewModel.getCurrentDetails.title, // 通过当前插件的信息获取插件标题
                    textAlign: TextAlign.center,
                  ), // 插件标题
                ), // 向左3个单位填充
              ],
            ), // 水平布局
          ), // 顶部应用栏
          body: viewModel.getPluginWidget(
            context,
            viewModel.getCurrentDetails, // 获取当前插件的信息
          ), // 通过当前插件的信息获取插件界面
        ), // 页面脚手架
      ), // 调用ViewModel
    ); // 窗口控制按钮叠加层
  }
}
