part of '../manager.dart';

final class DetailsPage extends UiPage {
  const DetailsPage({super.key});

  static const RouteName route = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

final class _DetailsPageState extends State<DetailsPage> {
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
      appBar: AppBar(title: Text('详细信息')),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const .only(
                      left: 32,
                      top: 16,
                      right: 32,
                      bottom: 8,
                    ),
                    child: Text(
                      '基础信息',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Consumer<DetailsViewModule>(
                    builder: (context, dvm, child) {
                      return Card.filled(
                        margin: const .symmetric(horizontal: 16, vertical: 8),
                        child: FutureBuilder(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) => Column(
                            children: [
                              ListTile(
                                title: Text('应用名称'),
                                subtitle: Text(
                                  snapshot.data?.appName ?? 'Unknown',
                                ),
                              ),
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              ListTile(
                                title: Text('版本名称'),
                                subtitle: Text(
                                  snapshot.data?.version ?? 'Unknown',
                                ),
                              ),
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              ListTile(
                                title: Text('版本号'),
                                subtitle: Text(
                                  snapshot.data?.buildNumber ?? 'Unknown',
                                ),
                              ),
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              ListTile(
                                title: Text('应用包名'),
                                subtitle: Text(
                                  snapshot.data?.packageName ?? 'Unknown',
                                ),
                              ),
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              ListTile(
                                title: Text('首次安装时间'),
                                subtitle: Text(
                                  dvm.formattDateString(
                                        snapshot.data?.installTime,
                                      ) ??
                                      'Unknown',
                                ),
                              ),
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                              ListTile(
                                title: Text('最后更新时间'),
                                subtitle: Text(
                                  dvm.formattDateString(
                                        snapshot.data?.updateTime,
                                      ) ??
                                      'Unknown',
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const .only(
                      left: 32,
                      top: 8,
                      right: 32,
                      bottom: 8,
                    ),
                    child: Text(
                      '服务声明',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Card.filled(
                    margin: const .only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 16,
                    ),
                    child: ListTile(
                      title: Text('由于使用此软件库的开发者的个人行为导致的违法违规, 与此软件库开发者无关.'),
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
