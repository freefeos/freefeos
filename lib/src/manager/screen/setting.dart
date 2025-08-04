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

  final NavController navController;

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
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 62,
                        height: 62,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          'Fe',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.primaryContainer,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('FreeFEOS'),
                          subtitle: Text('wyq0918dev'),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  child: Text(
                    'FreeFEOS 是一款综合工具类小程序, 使用MPFlutter框架进行开发, 为用户提供时钟、计算器等功能.',
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
                          message: '进入小程序',
                          child: FilledButton(
                            onPressed: () {
                              widget.navController.animateToFirst();
                            },
                            child: Text('进入小程序'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Consumer<OSAbility>(
                          builder: (context, ability, child) {
                            return ability.openCustomer(
                              child: AppUtils.nonNullWidget(child: child),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Tooltip(
                              message: '客服',
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text('客服'),
                              ),
                            ),
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
                  child: ListTile(title: Text('Card')),
                ),
                Card.filled(
                  margin: const EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 8,
                  ),
                  color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('相关小程序'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.keyboard_command_key,
                              color: ColorScheme.fromSeed(
                                seedColor: V.colors.ecosedPurple,
                                brightness: Theme.of(context).brightness,
                              ).primary,
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
                         
                        },
                      ),
                      const Divider(height: 1, indent: 16, endIndent: 16),
                      Consumer<OSAbility>(
                        builder: (context, ability, child) {
                          return ability.openSetting(
                            child: AppUtils.nonNullWidget(child: child),
                          );
                        },
                        child: ListTile(
                          title: Text('小程序设置'),
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
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 8,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Footer(style: FooterStyle.freefeos),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
