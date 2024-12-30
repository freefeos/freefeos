import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../utils/utils.dart';
import '../values/values.dart';
import '../view_model/view_model.dart';
import '../pages/about.dart';

/// 主页页面布局
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            constraints: const BoxConstraints(maxWidth: 840),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: Consumer<ManagerViewModel>(
                builder: (context, viewModel, child) => Column(
                  children: [
                    Tooltip(
                      message: '打开应用',
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        margin: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                          bottom: 8,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          child: ListTile(
                            leading: const FlutterLogo(),
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
                            trailing: Icon(Icons.keyboard_arrow_right),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            enabled: !AppUtils.getNavBoolValue(
                              context,
                              hideManager,
                            ),
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              AboutPage.route,
                              arguments: AppUtils.setNavBoolValue({
                                hideManager: true,
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        title: Text('随机一言'),
                        subtitle: Text(viewModel.getPoem),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                    Card.outlined(
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                        right: 16,
                        bottom: 16,
                      ),
                      child: InkWell(
                        onTap: () => Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pushNamed(
                          AboutPage.route,
                          arguments: AppUtils.setNavBoolValue({
                            hideManager: true,
                          }),
                        ),
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 6,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).managerHomeInfoAppName,
                                ),
                                subtitle: FutureBuilder(
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
                              ),
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).managerHomeInfoAppVersion,
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
                              ),
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).managerHomeInfoPlatform,
                                ),
                                subtitle: Text(
                                  Theme.of(context).platform.name,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  ).managerHomeInfoPluginCount,
                                ),
                                subtitle: Text(
                                  viewModel.pluginCount(),
                                ),
                              ),
                            ],
                          ),
                        ),
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
