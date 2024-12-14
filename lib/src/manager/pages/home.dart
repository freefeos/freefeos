import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../view_model/view_model.dart';
import 'about.dart';

/// 主页页面布局
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                      child: Tooltip(
                        message: '打开应用',
                        child: Card(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: InkWell(
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              AboutPage.route,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
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
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 6,
                          ),
                          child: ListTile(
                            title: Text('随机一言'),
                            subtitle: Text(viewModel.getPoem),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      child: Tooltip(
                        message: '关于',
                        child: Card.outlined(
                          child: InkWell(
                            // onTap: () => showDialog(
                            //   context: context,
                            //   useRootNavigator: true,
                            //   builder: (context) => AboutAlertDialog(),
                            // ),
                            onTap: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              AboutPage.route,
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
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                    //   child: Tooltip(
                    //     message: AppLocalizations.of(
                    //       context,
                    //     ).managerHomeLearnTooltip,
                    //     child: Card(
                    //       child: InkWell(
                    //         onTap: viewModel.launchPubDev,
                    //         borderRadius: BorderRadius.circular(12),
                    //         child: Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //             vertical: 12,
                    //             horizontal: 6,
                    //           ),
                    //           child: ListTile(
                    //             title: Text(
                    //               AppLocalizations.of(
                    //                 context,
                    //               ).managerHomeLearnTitle,
                    //             ),
                    //             subtitle: Text(
                    //               AppLocalizations.of(
                    //                 context,
                    //               ).managerHomeLearnDescription,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
