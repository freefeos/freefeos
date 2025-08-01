part of '../../manager.dart';

/// 模块页面布局
final class ModuleScreen extends UiScreen {
  const ModuleScreen({
    super.key,
    required super.title,
    required super.index,
    required super.label,
    required super.icon,
    required super.selectedIcon,
  });

  @override
  State<ModuleScreen> createState() => _ModuleScreenState();
}

class _ModuleScreenState extends State<ModuleScreen> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 模块列表
  final List<Widget> _moduleList = [];

  /// 组件列表
  final List<Widget> _componentList = [];

  @override
  void initState() {
    super.initState();
    final ModuleViewModel module = Provider.of<ModuleViewModel>(
      context,
      listen: false,
    );
    final OSAbility ability = Provider.of<OSAbility>(context, listen: false);
    module.init(ability);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModuleViewModel module = Provider.of<ModuleViewModel>(
      context,
      listen: false,
    );
    final List<Widget> modules = module.moduleList(
      context: context,
      showDetail: _showDetail,
      dividerBuilder: _divider,
      itemBuilder: _listItem,
    );
    final List<Widget> components = module.componentList(
      context: context,
      showDetail: _showDetail,
      dividerBuilder: _divider,
      itemBuilder: _listItem,
    );
    if (modules.length > _moduleList.length) {
      _moduleList.addAll(modules);
    }
    if (components.length > _componentList.length) {
      _componentList.addAll(components);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: ScreenAdapter(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            controller: _scrollController,
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
                    '模块',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Card.filled(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(children: _moduleList),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 32,
                  ),
                  child: Text(
                    '组件',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
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
                  child: Column(children: _componentList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider(BuildContext content) {
    return const Divider(height: 1, indent: 16, endIndent: 16);
  }

  Widget _listItem(
    BuildContext content,
    VoidCallback onTap,
    String title,
    IconData icon,
    bool isTop,
    bool isBottom,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: isTop ? Radius.circular(12) : Radius.zero,
          topRight: isTop ? Radius.circular(12) : Radius.zero,
          bottomLeft: isBottom ? Radius.circular(12) : Radius.zero,
          bottomRight: isBottom ? Radius.circular(12) : Radius.zero,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showDetail(
    BuildContext content,
    String title,
    String id,
    IconData icon,
    String description,
  ) async {
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          title: ListTile(
            contentPadding: const EdgeInsets.only(
              left: 24.0,
              top: 12.0,
              right: 24.0,
            ),
            trailing: Icon(
              icon,
              size: Theme.of(context).iconTheme.size,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(title),
            subtitle: Text(id),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
          ),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("确定"),
            ),
          ],
        );
      },
    );
  }
}
