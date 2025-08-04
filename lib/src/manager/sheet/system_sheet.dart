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

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false, // 禁用默认滚动条
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Card.filled(
                      margin: const EdgeInsets.only(
                        left: 16,
                        top: 0,
                        right: 16,
                        bottom: 8,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: ListTile(
                        leading: const FlutterLogo(),
                        title: Text('appName'),
                        subtitle: Text('subtitle'),
                        trailing: const Icon(Icons.arrow_right_rounded),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        onTap: () => Navigator.of(context)
                          ..pop()
                          ..pushNamed(AboutPage.route),
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
    );
  }
}
