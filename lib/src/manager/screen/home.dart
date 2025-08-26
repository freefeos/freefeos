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
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Consumer2<HomeViewModel, OSAbility>(
                  builder: (context, hvm, ability, _) {
                    return Card.filled(
                      color: hvm.getStateCardColor(context, ability),
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: Tooltip(
                        message: AppLocalizations.of(
                          context,
                        ).indexHomeStatuesCardTooltip,
                        child: ListTile(
                          leading: Icon(hvm.getStateCardIcon(ability)),
                          title: Text(hvm.getStateCardTitle(context, ability)),
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardAppId(ability.getAppId),
                              ),
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardEnvVersion(
                                  hvm.getStateCardEnv(context, ability),
                                ),
                              ),
                              Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeStatuesCardAppVersion(
                                  ability.getVersionName,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Card.filled(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(
                    children: [
                      Tooltip(
                        message: AppLocalizations.of(
                          context,
                        ).indexHomeInfoCardHostAppTooltip,
                        child: ListTile(
                          leading: const Icon(Icons.app_shortcut),
                          title: Text(
                            AppLocalizations.of(
                              context,
                            ).indexHomeInfoCardHostAppTitle,
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 12,
                            left: 24,
                            right: 24,
                            bottom: 3,
                          ),
                          subtitle: Consumer<OSAbility>(
                            builder: (context, ability, _) {
                              return Text(ability.getHostAppVersion);
                            },
                          ),
                        ),
                      ),
                      Tooltip(
                        message: AppLocalizations.of(
                          context,
                        ).indexHomeInfoCardBaseSdkTooltip,
                        child: ListTile(
                          leading: const Icon(Icons.code),
                          title: Text(
                            AppLocalizations.of(
                              context,
                            ).indexHomeInfoCardBaseSdkTitle,
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 3,
                            left: 24,
                            right: 24,
                            bottom: 3,
                          ),
                          subtitle: Consumer<OSAbility>(
                            builder: (context, ability, _) {
                              return Text(ability.getBaseSdkVersion);
                            },
                          ),
                        ),
                      ),
                      Tooltip(
                        message: AppLocalizations.of(
                          context,
                        ).indexHomeInfoCardVersionTooltip,
                        child: ListTile(
                          leading: const Icon(Icons.web),
                          title: Text(
                            AppLocalizations.of(
                              context,
                            ).indexHomeInfoCardVersionTitle,
                          ),
                          contentPadding: const EdgeInsets.only(
                            top: 3,
                            left: 24,
                            right: 24,
                            bottom: 12,
                          ),
                          subtitle: Consumer<OSAbility>(
                            builder: (context, ability, _) {
                              return Text(ability.getVersionName);
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
      ),
    );
  }
}
