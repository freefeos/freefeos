import 'package:flutter/material.dart';
import 'package:freefeos/src/manager/components/screen_adapter.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../components/app_title.dart';
import '../components/window_buttons_overlay.dart';
import '../utils/utils.dart';
import '../values/values.dart';
import '../view_model/view_model.dart';
import 'details.dart';
import 'index.dart';
import 'licenses.dart';
import 'manager.dart';
import 'setting.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  static const RouteName route = '/about';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text('关于应用'),
        ),
        body: ScreenAdapter(
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: Consumer<ManagerViewModel>(
                builder: (context, viewModel, _) => Column(
                  children: [
                    Card.filled(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: ListTile(
                        leading: const FlutterLogo(),
                        title: const AppTitle(),
                        subtitle: const AppSubTitle(),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 8,
                              right: 8,
                              bottom: 8,
                            ),
                            child: FilledButton.icon(
                              onPressed: () => Navigator.of(
                                context,
                                rootNavigator: true,
                              ).popUntil(
                                ModalRoute.withName(
                                  IndexPage.route,
                                ),
                              ),
                              icon: Icon(Icons.app_shortcut),
                              label: Text('进入应用'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8,
                              top: 8,
                              right: 16,
                              bottom: 8,
                            ),
                            child: OutlinedButton.icon(
                              onPressed: AppUtils.getNavBoolValue(
                                context,
                                hideManager,
                              )
                                  ? null
                                  : () => Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).pushNamed(
                                        ManagerPage.route,
                                        arguments: AppUtils.setNavBoolValue({
                                          hideManager: true,
                                          hideAbout: true,
                                        }),
                                      ),
                              icon: Icon(Icons.manage_accounts),
                              label: Text('管理器'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card.outlined(
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.info_outline),
                            title: Text('更多资料'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              DetailsPage.route,
                            ),
                          ),
                          Divider(
                            indent: 12,
                            endIndent: 12,
                            height: 0,
                          ),
                          ListTile(
                            leading: Icon(Icons.copyright_outlined),
                            title: Text('开放源代码许可'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              LicensesPage.route,
                            ),
                          ),
                          Divider(
                            indent: 12,
                            endIndent: 12,
                            height: 0,
                          ),
                          ListTile(
                            leading: Icon(Icons.settings_outlined),
                            title: Text('设置'),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              right: 12,
                            ),
                            enabled: !AppUtils.getNavBoolValue(
                              context,
                              hideSetting,
                            ),
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              SettingPage.route,
                              arguments: AppUtils.setNavBoolValue({
                                hideAbout: true,
                              }),
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
