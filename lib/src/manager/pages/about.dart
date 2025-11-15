part of '../manager.dart';

final class AboutPage extends UiPage {
  const AboutPage({super.key});

  static const RouteName route = '/about';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 应用信息
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((res) {
      setState(() => _packageInfo = res);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
    // 清空应用信息
    _packageInfo = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关于应用')),
      body: Scrollbar(
        controller: _scrollController,
        child: ScreenAdapter(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: .zero,
              child: Column(
                children: [
                  Card.filled(
                    margin: const .only(
                      left: 16,
                      top: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Tooltip(
                      message: '应用',
                      child: ListTile(
                        leading: const FlutterLogo(),
                        title: Text(
                          _packageInfo?.appName ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          _packageInfo?.version ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onTap: () =>
                            Navigator.of(context).pushNamed(DetailsPage.route),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Tooltip(
                            message: '进入应用',
                            child: FilledButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).popUntil(ModalRoute.withName(IndexPage.route)),
                              child: Text('进入应用'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Tooltip(
                            message: '管理器',
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).pushNamed(ManagerPage.route),
                              child: Text('管理器'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card.filled(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: ListTile(
                      title: Text(
                        'Powered by FreeFEOS',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Card.filled(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 16,
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('设置'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(SettingsPage.route);
                          },
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        ListTile(
                          title: Text('开放源代码许可'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.list,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(LicensesPage.route);
                          },
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
    );
  }
}
