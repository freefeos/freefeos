part of '../manager.dart';

final class SystemSheet extends UiStatefulComponent {
  const SystemSheet({super.key});

  @override
  State<SystemSheet> createState() => _SystemSheetState();
}

final class _SystemSheetState extends State<SystemSheet> {
  _SystemSheetState();

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
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(
                  context,
                ).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card.filled(
                        margin: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Consumer<OSAbility>(
                          builder: (context, ability, child) {
                            return ListTile(
                              leading: const FlutterLogo(),
                              title: Text(
                                _packageInfo?.appName ?? 'Unknown',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                _packageInfo?.version ?? 'Unknown',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.symmetric(
                                    horizontal: 16.0,
                                  ),
                              onTap: () => Navigator.of(context)
                                ..pop()
                                ..pushNamed(AboutPage.route),
                            );
                          },
                        ),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(ManagerPage.route),
                        child: Text('管理器'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(SettingsPage.route),
                        child: Text('设置'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1),
          ListTile(
            onTap: () => Navigator.of(context).pop(),
            title: Text('Cancel', textAlign: TextAlign.center),
            textColor: Theme.of(context).colorScheme.primary,
            titleAlignment: ListTileTitleAlignment.center,
            contentPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
