part of '../../manager.dart';

final class AppsPage extends UiPage {
  const AppsPage({super.key});

  static const RouteName route = '/apps';

  static const int ekit = 0;
  static const int wechat = 1;
  static const int clock = 2;
  static const int calculator = 3;

  static const String pageArgument = 'index';
  static const String exhibitArgumgent = 'exhibit';

  static const String routeQuery = 'shareRouteName';
  static const String pageQuery = 'sharePageName';

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  final NavController _navController = NavController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 注册导航
    _navController.register(
      context: context,
      defaultIndex: AppUtils.getNavValue(context, AppsPage.pageArgument) ?? 0,
      builders: [
        (context) {
          return const EcosedScreen(title: 'EKit', index: AppsPage.ekit);
        },
        (context) {
          return const WeChatScreen(title: '微信', index: AppsPage.wechat);
        },
        (context) {
          return const ClockScreen(title: '时钟', index: AppsPage.clock);
        },
        (context) {
          return const CalculatorScreen(
            title: '计算器',
            index: AppsPage.calculator,
          );
        },
      ],
    );
    // 设置分享信息
    Provider.of<OSAbility>(context, listen: false).setAppShareInfo(
      context: context,
      title: 'FreeFEOS - ${_navController.getCurrentTitle}',
      query: <dynamic, dynamic>{
        AppsPage.routeQuery: AppsPage.route,
        AppsPage.pageQuery: _navController.getCurrentIndex,
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppUtils.getNavValue(context, AppsPage.exhibitArgumgent) != true
              ? AppBar(
                centerTitle: true,
                title: NavTitle(navController: _navController),
              )
              : null,
      body: NavHost(navController: _navController),
    );
  }
}
