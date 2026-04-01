part of '../manager.dart';

/// 主页页面布局
final class HomeScreen extends UiScreen {
  const HomeScreen({
    super.key,
    required super.title,
    required super.index,
    required super.label,
    required super.icon,
    required super.selectedIcon,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ScreenAdapter(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false, // 禁用默认滚动条
          ),
          child: ListView(
            controller: _scrollController,
            children: [
              Consumer2<HomeViewModel, OSAbility>(
                builder: (context, hvm, ability, _) {
                  return Card.filled(
                    color: hvm.getStateCardColor(context, ability),
                    margin: const .only(
                      left: 16,
                      top: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Tooltip(
                      // message: AppLocalizations.of(
                      //   context,
                      // ).indexHomeStatuesCardTooltip,
                      message: '状态',
                      child: ListTile(
                        leading: Icon(hvm.getStateCardIcon(ability)),
                        title: Text(hvm.getStateCardTitle(context, ability)),
                        subtitle: FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) => Column(
                            mainAxisSize: .min,
                            mainAxisAlignment: .start,
                            crossAxisAlignment: .start,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardAppId(
                                  snapshot.data?.packageName ?? 'Unknown',
                                ),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardEnvVersion(
                                  hvm.getStateCardEnv(context, ability),
                                ),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardAppVersion(
                                  snapshot.data?.version ?? 'Unknown',
                                ),
                                maxLines: 1,
                                overflow: .ellipsis,
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12),
                        ),
                        contentPadding: const .symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Card.filled(
                margin: const .only(left: 16, top: 8, right: 16, bottom: 16),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Column(
                  children: [
                    Tooltip(
                      // message: AppLocalizations.of(
                      //   context,
                      // ).indexHomeInfoCardHostAppTooltip,
                      message: '应用版本',
                      child: ListTile(
                        leading: const Icon(Icons.app_shortcut),
                        title: Text(
                          // AppLocalizations.of(
                          //   context,
                          // ).indexHomeInfoCardHostAppTitle,
                          '应用版本',
                        ),
                        contentPadding: const .only(
                          top: 12,
                          left: 24,
                          right: 24,
                          bottom: 3,
                        ),
                        subtitle: FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) {
                            return Text(snapshot.data?.appName ?? 'Unknown');
                          },
                        ),
                      ),
                    ),
                    Tooltip(
                      // message: AppLocalizations.of(
                      //   context,
                      // ).indexHomeInfoCardBaseSdkTooltip,
                      message: 'Dart 版本',
                      child: ListTile(
                        leading: const Icon(Icons.code),
                        title: Text(
                          // AppLocalizations.of(
                          //   context,
                          // ).indexHomeInfoCardBaseSdkTitle,
                          'Dart 版本',
                        ),
                        contentPadding: const .only(
                          top: 3,
                          left: 24,
                          right: 24,
                          bottom: 3,
                        ),
                        subtitle: Consumer<OSAbility>(
                          builder: (context, ability, _) {
                            return Text('');
                          },
                        ),
                      ),
                    ),
                    Tooltip(
                      // message: AppLocalizations.of(
                      //   context,
                      // ).indexHomeInfoCardVersionTooltip,
                      message: 'Flutter 版本',
                      child: ListTile(
                        leading: const Icon(Icons.flutter_dash),
                        title: Text(
                          // AppLocalizations.of(
                          //   context,
                          // ).indexHomeInfoCardVersionTitle,
                          'Flutter 版本',
                        ),
                        contentPadding: const .only(
                          top: 3,
                          left: 24,
                          right: 24,
                          bottom: 12,
                        ),
                        subtitle: Consumer<OSAbility>(
                          builder: (context, ability, _) {
                            return Text(" ");
                          },
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
    );
  }
}
