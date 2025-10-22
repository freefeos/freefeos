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
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
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
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('应用名称'),
                              subtitle: Text(
                                _packageInfo?.appName ?? 'Unknown',
                              ),
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: Text('版本名称'),
                              subtitle: Text(
                                _packageInfo?.version ?? 'Unknown',
                              ),
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: Text('内部构建号'),
                              subtitle: Text(
                                _packageInfo?.buildNumber ?? 'Unknown',
                              ),
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: Text('应用包名'),
                              subtitle: Text(
                                _packageInfo?.packageName ?? 'Unknown',
                              ),
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: Text('首次安装时间'),
                              subtitle: Text(
                                dvm.formattDateString(
                                      _packageInfo?.installTime,
                                    ) ??
                                    'Unknown',
                              ),
                            ),
                            const Divider(height: 1, indent: 16, endIndent: 16),
                            ListTile(
                              title: Text('最后更新时间'),
                              subtitle: Text(
                                dvm.formattDateString(
                                      _packageInfo?.updateTime,
                                    ) ??
                                    'Unknown',
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
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
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 16,
                    ),
                    child: ListTile(
                      leading: Icon(Icons.warning_amber),
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
