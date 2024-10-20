import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

import '../event/event_buffer.dart';
import '../event/rendered_event.dart';
import '../framework/ansi_parser.dart';
import '../framework/log.dart';
import '../framework/toast.dart';
import '../intl/l10n.dart';
import '../plugin/plugin_details.dart';
import '../values/route.dart';
import '../viewmodel/system_mmvm.dart';
import 'about.dart';

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
              child: Consumer<SystemViewModel>(
                builder: (context, viewModel, child) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: InkWell(
                          onTap: () => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).popUntil(
                            ModalRoute.withName(routeRoot),
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
                                  String text = IntlLocalizations.of(
                                    context,
                                  ).unknown;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      text = IntlLocalizations.of(
                                        context,
                                      ).waiting;
                                      break;
                                    case ConnectionState.done:
                                      if (snapshot.hasError) {
                                        text = IntlLocalizations.of(
                                          context,
                                        ).error;
                                        break;
                                      }
                                      if (snapshot.hasData) {
                                        text = snapshot.data ??
                                            IntlLocalizations.of(
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
                                  String text = IntlLocalizations.of(
                                    context,
                                  ).unknown;
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      text = IntlLocalizations.of(
                                        context,
                                      ).waiting;
                                      break;
                                    case ConnectionState.done:
                                      if (snapshot.hasError) {
                                        text = IntlLocalizations.of(
                                          context,
                                        ).error;
                                        break;
                                      }
                                      if (snapshot.hasData) {
                                        text = snapshot.data ??
                                            IntlLocalizations.of(
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
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeInfoAppName,
                                ),
                                subtitle: FutureBuilder(
                                  future: viewModel.getAppName(),
                                  builder: (context, snapshot) {
                                    String text = IntlLocalizations.of(
                                      context,
                                    ).unknown;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        text = IntlLocalizations.of(
                                          context,
                                        ).waiting;
                                        break;
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          text = IntlLocalizations.of(
                                            context,
                                          ).error;
                                          break;
                                        }
                                        if (snapshot.hasData) {
                                          text = snapshot.data ??
                                              IntlLocalizations.of(
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
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeInfoAppVersion,
                                ),
                                subtitle: FutureBuilder(
                                  future: viewModel.getAppVersion(),
                                  builder: (context, snapshot) {
                                    String text = IntlLocalizations.of(
                                      context,
                                    ).unknown;
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        text = IntlLocalizations.of(
                                          context,
                                        ).waiting;
                                        break;
                                      case ConnectionState.done:
                                        if (snapshot.hasError) {
                                          text = IntlLocalizations.of(
                                            context,
                                          ).error;
                                          break;
                                        }
                                        if (snapshot.hasData) {
                                          text = snapshot.data ??
                                              IntlLocalizations.of(
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
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeInfoPlatform,
                                ),
                                subtitle: Text(
                                  Theme.of(context).platform.name,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeInfoPluginCount,
                                ),
                                subtitle: Text(
                                  viewModel.pluginCount(),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //     vertical: 8,
                              //     horizontal: 24,
                              //   ),
                              //   child: Row(
                              //     mainAxisSize: MainAxisSize.max,
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       FilledButton.icon(
                              //         onPressed: () => showDialog(
                              //           context: context,
                              //           useRootNavigator: true,
                              //           builder: (context) => const SystemAbout(
                              //             isPackage: false,
                              //           ),
                              //         ),
                              //         icon: const Icon(Icons.info_outline),
                              //         label: Text(
                              //           IntlLocalizations.of(
                              //             context,
                              //           ).managerHomeInfoAbout,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      child: Tooltip(
                        message: IntlLocalizations.of(
                          context,
                        ).managerHomeLearnTooltip,
                        child: Card(
                          child: InkWell(
                            onTap: viewModel.launchPubDev,
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 6,
                              ),
                              child: ListTile(
                                title: Text(
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeLearnTitle,
                                ),
                                subtitle: Text(
                                  IntlLocalizations.of(
                                    context,
                                  ).managerHomeLearnDescription,
                                ),
                              ),
                            ),
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

class LogcatPage extends StatefulWidget {
  const LogcatPage({super.key});

  @override
  State<LogcatPage> createState() => _LogcatPageState();
}

class _LogcatPageState extends State<LogcatPage> {
  final ListQueue<RenderedEvent> _renderedBuffer = ListQueue();
  final ScrollController _scrollController = ScrollController();
  final StringBuffer _logs = StringBuffer('Start: ');
  List<RenderedEvent> _filteredBuffer = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _renderedBuffer.clear();
    for (var event in EventBuffer.outputEventBuffer) {
      final IAnsiParser parser = AnsiParser(
        context: context,
        showTips: () => Toast.makeToast(
          context: context,
          text: IntlLocalizations.of(
            context,
          ).managerLogCopyTips,
        ).show(),
      );
      final String text = event.lines.join('\n');
      int currentId = 0;
      parser.parse(text);
      _renderedBuffer.add(
        RenderedEvent(
          currentId++,
          event.level,
          TextSpan(children: parser.getSpans),
          text.toLowerCase(),
        ),
      );
    }
    setState(
      () => _filteredBuffer = _renderedBuffer.where(
        (it) {
          if (it.level.value < Level.CONFIG.value) {
            return false;
          } else {
            return true;
          }
        },
      ).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logs.clear();
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
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            itemCount: _filteredBuffer.length,
            itemBuilder: (context, index) {
              final RenderedEvent logEntry = _filteredBuffer[index];
              _logs.write("${logEntry.lowerCaseText}\n");
              return Text.rich(
                logEntry.span,
                key: Key(logEntry.id.toString()),
                style: TextStyle(
                  fontSize: 14,
                  color: logEntry.level.toColor(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

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
            child: Consumer<SystemViewModel>(
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
                            ).pushNamed(routePlugin),
                            () => showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) => const SystemAbout(
                                isPackage: true,
                              ),
                            ),
                            () => showDialog(
                              context: context,
                              useRootNavigator: true,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('无界面'),
                                  content: Text('此插件未提供用户界面.'),
                                  actions: [
                                    Tooltip(
                                      message: '确定',
                                      child: TextButton(
                                        onPressed: () => Navigator.of(
                                          context,
                                          rootNavigator: true,
                                        ).pop(),
                                        child: Text('确定'),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                            child: Consumer<SystemViewModel>(
                              builder: (context, viewModel, child) => Column(
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
                                                )
                                                    .textTheme
                                                    .titleMedium
                                                    ?.fontSize,
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
                                              '${IntlLocalizations.of(context).managerPluginChannel}: ${details.channel}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.fontSize,
                                                fontFamily: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .bodySmall
                                                    ?.fontFamily,
                                                height: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.height,
                                              ),
                                            ),
                                            Text(
                                              '${IntlLocalizations.of(context).managerPluginAuthor}: ${details.author}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall?.fontSize,
                                                fontFamily: Theme.of(
                                                  context,
                                                )
                                                    .textTheme
                                                    .bodySmall
                                                    ?.fontFamily,
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

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: const Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
