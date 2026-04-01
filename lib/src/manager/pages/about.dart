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

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
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
            child: ListView(
              controller: _scrollController,
              children: [
                Card.filled(
                  margin: const .only(left: 16, top: 16, right: 16, bottom: 8),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Tooltip(
                    message: '应用',
                    child: FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) => ListTile(
                        leading: const FlutterLogo(),
                        title: Text(
                          snapshot.data?.appName ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          snapshot.data?.version ?? 'Unknown',
                          overflow: .ellipsis,
                          maxLines: 1,
                        ),
                        contentPadding: const .symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        trailing: Row(
                          mainAxisSize: .min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(12.0),
                        ),
                        onTap: () =>
                            Navigator.of(context).pushNamed(DetailsPage.route),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const .only(left: 16, top: 8, right: 16, bottom: 8),
                  child: Row(
                    mainAxisSize: .max,
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
                  margin: const .only(left: 16, top: 8, right: 16, bottom: 8),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: ListTile(
                    title: Text(
                      'Powered by FreeFEOS',
                      overflow: .ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                Card.filled(
                  margin: const .only(left: 16, top: 8, right: 16, bottom: 16),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('设置'),
                        trailing: Row(
                          mainAxisSize: .min,
                          children: [
                            Icon(
                              Icons.settings,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        contentPadding: const .symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: .only(
                            topLeft: .circular(12),
                            topRight: .circular(12),
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).pushNamed(SettingsPage.route),
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      ListTile(
                        title: Text('开放源代码许可'),
                        trailing: Row(
                          mainAxisSize: .min,
                          children: [
                            Icon(
                              Icons.list,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        contentPadding: const .symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: .only(
                            bottomLeft: .circular(12),
                            bottomRight: .circular(12),
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).pushNamed(LicensesPage.route),
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
