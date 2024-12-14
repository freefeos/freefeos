import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/model/model.dart';
import '../intl/app_localizations.dart';
import '../view_model/view_model.dart';
import 'about.dart';
import 'plugin_ui.dart';

/// 插件页面布局
class PluginPage extends StatefulWidget {
  const PluginPage({super.key});

  @override
  State<PluginPage> createState() => _PluginPageState();
}

class _PluginPageState extends State<PluginPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              builder: (context, viewModel, child) => ListView.builder(
                controller: _scrollController,
                itemCount: viewModel.getPluginDetailsList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  // 首项
                  final PluginDetails first =
                      viewModel.getPluginDetailsList.first;
                  // 尾项
                  final PluginDetails last =
                      viewModel.getPluginDetailsList.last;
                  // 项
                  final PluginDetails details =
                      viewModel.getPluginDetailsList[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      top: first == details ? 12 : 6,
                      bottom: last == details ? 12 : 6,
                      left: 12,
                      right: 12,
                    ),
                    child: Card(
                      child: Tooltip(
                        message: viewModel.getPluginTooltip(context, details),
                        child: InkWell(
                          onTap: () => viewModel.clickPlugin(
                            context,
                            details,
                            () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              PluginUiPage.route,
                            ),
                            // () => showDialog(
                            //   context: context,
                            //   useRootNavigator: true,
                            //   builder: (context) => AboutAlertDialog(),
                            // ),
                            () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pushNamed(
                              AboutPage.route,
                            ),
                            // () => Toast.makeToast(
                            //   context: context,
                            //   text: '此插件未提供用户界面.',
                            // ).show(),
                            () => ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '此插件未提供用户界面.',
                                ),
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            details.title,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: Theme.of(
                                                context,
                                              ).textTheme.titleMedium?.fontSize,
                                              fontFamily: Theme.of(
                                                context,
                                              )
                                                  .textTheme
                                                  .titleMedium
                                                  ?.fontFamily,
                                              height: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.height,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context).managerPluginChannel}: ${details.channel}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.fontSize,
                                              fontFamily: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.fontFamily,
                                              height: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.height,
                                            ),
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context).managerPluginAuthor}: ${details.author}',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.fontSize,
                                              fontFamily: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.fontFamily,
                                              height: Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.height,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: viewModel.getPluginIcon(
                                        context,
                                        details,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  details.description,
                                  textAlign: TextAlign.start,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.apply(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  maxLines: 4,
                                ),
                                const SizedBox(height: 16),
                                const Divider(),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        viewModel.getPluginType(
                                          context,
                                          details,
                                        ),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
