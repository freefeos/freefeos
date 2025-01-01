import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/app_title.dart';
import '../components/screen_adapter.dart';
import '../intl/app_localizations.dart';
import '../pages/details.dart';
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
    return ScreenAdapter(
      child: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          child: Consumer<ManagerViewModel>(
            builder: (context, viewModel, _) => Column(
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
                        title: const AppTitle(),
                        subtitle: const AppSubTitle(),
                        trailing: const Icon(Icons.keyboard_arrow_right),
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
                      DetailsPage.route,
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
                            subtitle: const AppTitle(),
                          ),
                          ListTile(
                            title: Text(
                              AppLocalizations.of(
                                context,
                              ).managerHomeInfoAppVersion,
                            ),
                            subtitle: const AppSubTitle(),
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
    );
  }
}
