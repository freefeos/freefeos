import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/types/types.dart';
import '../intl/app_localizations.dart';
import '../values/values.dart';
import '../components/window_buttons_overlay.dart';
import '../utils/utils.dart';
import '../view_model/view_model.dart';
import 'details.dart';
import 'index.dart';
import 'licenses.dart';
import 'manager.dart';
import 'settings.dart';

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
        body: SafeArea(
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  child: Consumer<ManagerViewModel>(
                    builder: (context, viewModel, _) => Column(
                      children: [
                        Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          margin: EdgeInsets.only(
                            left: 12,
                            top: 12,
                            right: 12,
                            bottom: 6,
                          ),
                          child: ListTile(
                            leading: FlutterLogo(
                              size: 60,
                              style: FlutterLogoStyle.stacked,
                            ),
                            title: FutureBuilder(
                              future: viewModel.getAppName(),
                              builder: (context, snapshot) {
                                String text = AppLocalizations.of(
                                  context,
                                ).unknown;
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    text = AppLocalizations.of(
                                      context,
                                    ).waiting;
                                    break;
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      text = AppLocalizations.of(
                                        context,
                                      ).error;
                                      break;
                                    }
                                    if (snapshot.hasData) {
                                      text = snapshot.data ??
                                          AppLocalizations.of(
                                            context,
                                          ).sNull;
                                      break;
                                    }
                                    break;
                                  default:
                                    break;
                                }
                                return Text(text);
                              },
                            ),
                            subtitle: FutureBuilder(
                              future: viewModel.getAppVersion(),
                              builder: (context, snapshot) {
                                String text = AppLocalizations.of(
                                  context,
                                ).unknown;
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    text = AppLocalizations.of(
                                      context,
                                    ).waiting;
                                    break;
                                  case ConnectionState.done:
                                    if (snapshot.hasError) {
                                      text = AppLocalizations.of(
                                        context,
                                      ).error;
                                      break;
                                    }
                                    if (snapshot.hasData) {
                                      text = snapshot.data ??
                                          AppLocalizations.of(
                                            context,
                                          ).sNull;
                                      break;
                                    }
                                    break;
                                  default:
                                    break;
                                }
                                return Text(text);
                              },
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 24,
                              top: 12,
                              right: 24,
                              bottom: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 12,
                                  top: 6,
                                  right: 6,
                                  bottom: 6,
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
                                padding: EdgeInsets.only(
                                  left: 6,
                                  top: 6,
                                  right: 12,
                                  bottom: 6,
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
                                            arguments:
                                                AppUtils.setNavBoolValue({
                                              hideManager: true,
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
                          margin: EdgeInsets.only(
                            left: 12,
                            top: 6,
                            right: 12,
                            bottom: 12,
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
                                contentPadding: EdgeInsets.only(
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
                                contentPadding: EdgeInsets.only(
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
                                contentPadding: EdgeInsets.only(
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
        ),
      ),
    );
  }
}
