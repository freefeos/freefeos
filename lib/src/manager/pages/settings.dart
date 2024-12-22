import 'package:flutter/material.dart';
import 'package:freefeos/src/manager/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../components/window_buttons_overlay.dart';
import '../values/values.dart';
import '../view_model/view_model.dart';
import 'about.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static const RouteName route = '/setting';

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('设置'),
        ),
        body: SettingScreen(
          isManager: false,
        ),
      ),
    );
  }
}

/// 设置页面布局
class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
    this.isManager = true,
  });

  final bool isManager;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: false,
      right: true,
      bottom: false,
      minimum: EdgeInsets.zero,
      maintainBottomViewPadding: true,
      child: Align(
        alignment: Alignment.topCenter,
        child: Scrollbar(
          controller: _scrollController,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 840,
            ),
            child: Consumer<ManagerViewModel>(
              builder: (context, viewModel, child) => SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Tooltip(
                            message: '关于 FreeFEOS',
                            child: ListTile(
                              title: Text('关于'),
                              subtitle: Text('关于 FreeFEOS'),
                              leading: Icon(Icons.info_outline),
                              onTap: () => Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pushNamed(
                                AboutPage.route,
                                arguments: AppUtils.setNavBoolValue({
                                  hideManager: widget.isManager,
                                  hideSetting: true,
                                }),
                              ),
                              contentPadding: const EdgeInsets.only(
                                top: 6,
                                left: 24,
                                right: 24,
                                bottom: 3,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              enabled: !AppUtils.getNavBoolValue(
                                context,
                                hideAbout,
                              ),
                            ),
                          ),
                          Tooltip(
                            message: '了解如何使用 FreeFEOS 进行开发',
                            child: ListTile(
                              title: Text('了解更多'),
                              subtitle: Text('了解如何使用 FreeFEOS 进行开发'),
                              leading: Icon(Icons.open_in_browser),
                              onTap: () => viewModel.launchPubDev(),
                              contentPadding: const EdgeInsets.only(
                                top: 3,
                                left: 24,
                                right: 24,
                                bottom: 6,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
