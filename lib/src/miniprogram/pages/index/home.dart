part of '../../miniprogram.dart';

/// 主页页面布局
final class HomeScreen extends UiScreen {
  const HomeScreen({
    super.key,
    required super.title,
    required super.index,
    required super.label,
    required super.icon,
    required super.selectedIcon,
    this.isExhibit = false,
  });

  final bool isExhibit;

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
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: widget.isExhibit ? null : EdgeInsets.zero,
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
                      message:
                          AppLocalizations.of(
                            context,
                          ).indexHomeStatuesCardTooltip,
                      child: ListTile(
                        leading: Icon(
                          widget.isExhibit
                              ? Icons.info_outline
                              : hvm.getStateCardIcon(ability),
                        ),
                        title: Text(
                          widget.isExhibit
                              ? 'FreeFEOS'
                              : hvm.getStateCardTitle(context, ability),
                        ),
                        subtitle:
                            widget.isExhibit
                                ? Text(
                                  'FreeFEOS 是一款综合工具类小程序, 使用MPFlutter框架进行开发, 为用户提供时钟、计算器等功能.',
                                )
                                : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      ).indexHomeStatuesCardAppId(
                                        ability.getAppId,
                                      ),
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
              Offstage(
                offstage: widget.isExhibit,
                child: Card.filled(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(
                    children: [
                      Tooltip(
                        message:
                            AppLocalizations.of(
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
                        message:
                            AppLocalizations.of(
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
                        message:
                            AppLocalizations.of(
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
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: widget.isExhibit ? 8 : 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12.0),
                  ), // 裁剪右上角角标多余部分 12 为与OutlineCard相同大小的圆角
                  child: Banner(
                    shadow: BoxShadow(),
                    message:
                        AppLocalizations.of(context).indexHomeAppsCardBanner,
                    color: Theme.of(context).colorScheme.primary,
                    textStyle: (Theme.of(context).textTheme.labelSmall ??
                            TextStyle(
                              color: Colors.white,
                              fontSize: 10.2,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                            ))
                        .copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                    location: BannerLocation.topEnd, // 角标位于右上角
                    child: Card.filled(
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16,
                                  top: 8,
                                  right: 16,
                                  bottom: 4,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      ).indexHomeAppsCardTitle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex:
                                          AppUtils.getNavValue(
                                                    context,
                                                    'showBack',
                                                  ) ==
                                                  true
                                              ? 1
                                              : 0,
                                      child: Offstage(
                                        offstage:
                                            AppUtils.getNavValue(
                                              context,
                                              'showBack',
                                            ) !=
                                            true,
                                        child: Tooltip(
                                          message: 'Back',
                                          child: TextButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            label: Text(
                                              '返回',
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelMedium?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                              ),
                                            ),
                                            icon: Icon(
                                              Icons.arrow_back_ios_new,
                                              color:
                                                  Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: Offstage(
                                        offstage:
                                            AppUtils.getNavValue(
                                              context,
                                              'showBack',
                                            ) !=
                                            true,
                                        child: SizedBox(width: 12),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message:
                                            AppLocalizations.of(
                                              context,
                                            ).indexHomeAppsCardEKitAppTooltip,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: V.colors.ecosedPurple,
                                              brightness:
                                                  Theme.of(context).brightness,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              return TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(
                                                    context,
                                                  ).pushNamed(
                                                    AppsPage.route,
                                                    arguments:
                                                        AppUtils.setNavValue({
                                                          AppsPage.pageArgument:
                                                              AppsPage.ekit,
                                                          AppsPage.exhibitArgumgent:
                                                              widget.isExhibit,
                                                        }),
                                                  );
                                                },
                                                label: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  ).indexHomeAppsCardEKitAppName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                      ),
                                                ),
                                                icon: Icon(
                                                  Icons.keyboard_command_key,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 0,
                                      child: SizedBox(width: 12),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Tooltip(
                                        message:
                                            AppLocalizations.of(
                                              context,
                                            ).indexHomeAppsCardWeChatAppTooltip,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.fromSeed(
                                              seedColor: V.colors.wechatGreen,
                                              brightness:
                                                  Theme.of(context).brightness,
                                            ),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              return TextButton.icon(
                                                onPressed: () {
                                                  Navigator.of(
                                                    context,
                                                  ).pushNamed(
                                                    AppsPage.route,
                                                    arguments:
                                                        AppUtils.setNavValue({
                                                          AppsPage.pageArgument:
                                                              AppsPage.wechat,
                                                          AppsPage.exhibitArgumgent:
                                                              widget.isExhibit,
                                                        }),
                                                  );
                                                },
                                                label: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  ).indexHomeAppsCardWeChatAppName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Theme.of(context)
                                                                .colorScheme
                                                                .primary,
                                                      ),
                                                ),
                                                icon: Icon(
                                                  Icons.wechat,
                                                  color:
                                                      Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 1),
                          Tooltip(
                            message:
                                AppLocalizations.of(
                                  context,
                                ).indexHomeAppsCardClockAppTooltip,
                            child: ListTile(
                              leading: const Icon(Icons.access_time),
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeAppsCardClockAppName,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              onTap:
                                  () => Navigator.of(context).pushNamed(
                                    AppsPage.route,
                                    arguments: AppUtils.setNavValue({
                                      AppsPage.pageArgument: AppsPage.clock,
                                      AppsPage.exhibitArgumgent:
                                          widget.isExhibit,
                                    }),
                                  ),
                            ),
                          ),
                          Divider(height: 1, indent: 16, endIndent: 16),
                          Tooltip(
                            message:
                                AppLocalizations.of(
                                  context,
                                ).indexHomeAppsCardCalculatorAppTooltip,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                ),
                              ),
                              leading: const Icon(Icons.calculate),
                              title: Text(
                                AppLocalizations.of(
                                  context,
                                ).indexHomeAppsCardCalculatorAppName,
                              ),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              onTap:
                                  () => Navigator.of(context).pushNamed(
                                    AppsPage.route,
                                    arguments: AppUtils.setNavValue({
                                      AppsPage.pageArgument:
                                          AppsPage.calculator,
                                      AppsPage.exhibitArgumgent:
                                          widget.isExhibit,
                                    }),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: !widget.isExhibit,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Footer(style: FooterStyle.freefeos),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
