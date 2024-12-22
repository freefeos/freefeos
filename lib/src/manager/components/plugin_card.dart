import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/model/model.dart';
import '../intl/app_localizations.dart';
import '../pages/about.dart';
import '../pages/plugin_ui.dart';
import '../utils/utils.dart';
import '../values/values.dart';
import '../view_model/view_model.dart';

class PluginCard extends StatelessWidget {
  const PluginCard({
    super.key,
    required this.details,
    required this.margin,
    required this.enableAbout,
  });

  final PluginDetails details;
  final EdgeInsetsGeometry margin;
  final bool enableAbout;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) => Card(
        margin: margin,
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
                PluginPage.route,
              ),
              enableAbout
                  ? () => Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(
                        AboutPage.route,
                        arguments: AppUtils.setNavBoolValue({
                          hideManager: true,
                        }),
                      )
                  : () => ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            '此插件未提供用户界面.',
                          ),
                        ),
                      ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                ).textTheme.titleMedium?.fontFamily,
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
                        padding: const EdgeInsets.symmetric(
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
  }
}
