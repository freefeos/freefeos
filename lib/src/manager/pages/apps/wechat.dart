part of '../../manager.dart';

final class WeChatScreen extends UiScreen {
  const WeChatScreen({super.key, required super.title, required super.index});

  @override
  State<WeChatScreen> createState() => _WeChatScreenState();
}

class _WeChatScreenState extends State<WeChatScreen> {
  /// 滚动控制器
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
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Header(
                style: HeaderStyle.wechat,
                showBack:
                    AppUtils.getNavValue(context, AppsPage.exhibitArgumgent) ==
                    true,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: V.colors.wechatGreen,
                    brightness: Theme.of(context).brightness,
                  ),
                ),
                child: Builder(
                  builder: (context) {
                    return Card.filled(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      color: Theme.of(context).colorScheme.surfaceContainerHigh,
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Icon(Icons.wechat, color: Colors.white),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        title: Text('微信'),
                        subtitle: Text('微信, 是一种生活方式.'),
                        trailing: Consumer<OSAbility>(
                          builder: (context, ability, child) {
                            return ability.openWeChat(
                              child: AppUtils.nonNullWidget(child: child),
                            );
                          },
                          child: Tooltip(
                            message: '微信',
                            child: FilledButton(
                              onPressed: () {},
                              child: Text('打开'),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Card.filled(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Column(
                  children: [
                    Tooltip(
                      message: '客户端版本',
                      child: ListTile(
                        leading: Icon(Icons.app_shortcut),
                        title: Text('客户端版本'),
                        subtitle: Consumer<OSAbility>(
                          builder: (_, ability, __) {
                            return Text(ability.getHostAppVersion);
                          },
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 12,
                          left: 24,
                          right: 24,
                          bottom: 3,
                        ),
                      ),
                    ),
                    Tooltip(
                      message: '基础库版本',
                      child: ListTile(
                        leading: Icon(Icons.code),
                        title: Text('基础库版本'),
                        subtitle: Consumer<OSAbility>(
                          builder: (_, ability, __) {
                            return Text(ability.getBaseSdkVersion);
                          },
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 3,
                          left: 24,
                          right: 24,
                          bottom: 12,
                        ),
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
                child: Footer(style: FooterStyle.wechat),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
