part of '../manager.dart';

/// 设置页面布局
final class SettingScreen extends UiScreen {
  const SettingScreen({
    super.key,
    required super.title,
    required super.index,
    required super.label,
    required super.icon,
    required super.selectedIcon,
    required this.navController,
  });

  final NavController? navController;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final ScrollController _scrollController = ScrollController();

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
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false, // 禁用默认滚动条
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    top: 16,
                    right: 32,
                    bottom: 8,
                  ),
                  child: Text(
                    '应用信息',
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
                    bottom: 8,
                  ),
                  child: ListTile(
                    title: Text('详细信息'),
                    subtitle: Text('应用的详细信息'),
                    leading: Icon(Icons.info_outline),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: () {
                      Navigator.of(context).pushNamed(DetailsPage.route);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 32,
                    top: 8,
                    right: 32,
                    bottom: 8,
                  ),
                  child: Text(
                    '了解更多',
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
                  child: ListTile(
                    title: Text('了解更多'),
                    subtitle: Text('在 pub.dev 上查看 freefeos 包'),
                    leading: const Icon(Icons.open_in_browser),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onTap: () {
                      launchUrl(Uri.parse('https://pub.dev/packages/freefeos'));
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
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
