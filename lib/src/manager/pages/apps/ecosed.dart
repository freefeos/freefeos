part of '../../manager.dart';

final class EcosedScreen extends UiScreen {
  const EcosedScreen({super.key, required super.title, required super.index});

  @override
  State<EcosedScreen> createState() => _EcosedScreenState();
}

class _EcosedScreenState extends State<EcosedScreen> {
  _EcosedScreenState();

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                style: HeaderStyle.ecosedkit,
                showBack:
                    AppUtils.getNavValue(context, AppsPage.exhibitArgumgent) ==
                    true,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: V.colors.ecosedPurple,
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
                          alignment: Alignment.center,
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Icon(
                            Icons.keyboard_command_key,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        title: Text('EcosedKit'),
                        subtitle: Text('EKit'),
                        trailing: Consumer<OSAbility>(
                          builder: (context, ability, child) {
                            return ability.openEKit(
                              child: AppUtils.nonNullWidget(child: child),
                            );
                          },
                          child: Tooltip(
                            message: 'EcosedKit',
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
                    const Tooltip(
                      message: 'FreeFEOS Connect',
                      child: ListTile(
                        leading: Icon(Icons.connect_without_contact),
                        title: Text('FreeFEOS Connect'),
                        subtitle: Text('单击打开按钮打开EcosedKit'),
                        contentPadding: EdgeInsets.only(
                          top: 12,
                          left: 24,
                          right: 24,
                          bottom: 3,
                        ),
                      ),
                    ),
                    const Tooltip(
                      message: 'UniApp-X',
                      child: ListTile(
                        leading: Icon(Icons.app_shortcut),
                        title: Text('UniApp-X'),
                        subtitle: Text('微信小程序、Web、Android.'),
                        contentPadding: EdgeInsets.only(
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
                child: Footer(style: FooterStyle.ecosedkit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
