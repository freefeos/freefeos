import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../view_model/view_model.dart';

class AppRootView extends StatefulWidget {
  const AppRootView({super.key});

  @override
  State<AppRootView> createState() => _AppRootViewState();
}

class _AppRootViewState extends State<AppRootView>
    with AutomaticKeepAliveClientMixin {
  /// 启用状态保持
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => Container(
        child: viewModel.getChild,
      ),
    );
  }
}
