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
      body: Consumer<DetailsViewModule>(
        builder: (context, dvm, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('应用名称: ${_packageInfo?.appName ?? 'Unknown'}'),
              Text('版本名称: ${_packageInfo?.version ?? 'Unknown'}'),
              Text('内部构建号: ${_packageInfo?.buildNumber ?? 'Unknown'}'),
              Text('应用包名: ${_packageInfo?.packageName ?? 'Unknown'}'),
              Text(
                '首次安装时间: ${dvm.formattDateString(_packageInfo?.installTime) ?? 'Unknown'}',
              ),
              Text(
                '最后更新时间: ${dvm.formattDateString(_packageInfo?.updateTime) ?? 'Unknown'}',
              ),
            ],
          );
        },
      ),
    );
  }
}
