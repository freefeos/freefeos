import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../components/app_banner.dart';
import '../components/app_root_view.dart';
import '../components/window_buttons_overlay.dart';
import '../view_model/view_model.dart';

/// 首页
class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  /// 首页路由地址
  static const RouteName route = '/';

  /// 创建 State
  @override
  State<IndexPage> createState() => _IndexPageState();
}

/// 首页 State
class _IndexPageState extends State<IndexPage> {
  _IndexPageState();

  /// UI构建方法
  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) {
        // 附加构建上下文
        viewModel.attachBuildContext(context);
        // 使用容器包裹返回UI
        return Container(child: child);
      },
      child: WindowButtonsOverlay(
        isIndex: true,
        child: AppBanner(
          child: AppRootView(),
        ), // 应用角标
      ), // 窗口按钮叠加层
    );
  }
}
