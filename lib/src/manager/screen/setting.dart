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
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('了解更多'),
            subtitle: Text('在 pub.dev 上查看'),
            leading: Icon(Icons.open_in_browser),
            onTap: () {
              launchUrl(Uri.parse('https://pub.dev/packages/freefeos'));
            },
          ),
        ),
      ],
    );
  }
}
