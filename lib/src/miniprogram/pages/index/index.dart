part of '../../miniprogram.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  static const RouteName route = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final NavController _navController = NavController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navController.register(
      context: context,
      defaultIndex: 0,
      builders: [
        (context) {
          return HomeScreen(
            title: '主页',
            index: 0,
            label: '主页',
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
          );
        },
        (context) {
          return LogcatScreen(
            title: '日志',
            index: 1,
            label: '日志',
            icon: Icons.bug_report_outlined,
            selectedIcon: Icons.bug_report,
          );
        },
        (context) {
          return ModuleScreen(
            title: '模块',
            index: 2,
            label: '模块',
            icon: Icons.layers_outlined,
            selectedIcon: Icons.layers,
          );
        },
        (context) {
          return SettingScreen(
            title: '设置',
            index: 3,
            label: '设置',
            icon: Icons.settings_outlined,
            selectedIcon: Icons.settings,
            navController: _navController,
          );
        },
      ],
    );
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: NavDrawer(
          navController: _navController,
          header: UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.pinkAccent, Colors.blueAccent],
              ),
            ),
            margin: EdgeInsets.zero,
            currentAccountPicture: FlutterLogo(
              textColor: Colors.white,
              style: FlutterLogoStyle.horizontal,
            ),
            accountName: Text("feOS"),
            accountEmail: Text("FreeFEOS Project"),
          ),
          others: <Widget>[
            Builder(
              builder: (context) {
                return ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.keyboard_command_key),
                  title: Text('EcosedKit'),
                  iconColor:
                      ColorScheme.fromSeed(
                        seedColor: V.colors.ecosedPurple,
                        brightness: Theme.of(context).brightness,
                      ).primary,
                  textColor:
                      ColorScheme.fromSeed(
                        seedColor: V.colors.ecosedPurple,
                        brightness: Theme.of(context).brightness,
                      ).primary,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed(
                      AppsPage.route,
                      arguments: AppUtils.setNavValue({
                        AppsPage.pageArgument: AppsPage.ekit,
                        AppsPage.exhibitArgumgent: false,
                      }),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                return ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.wechat),
                  title: Text('微信'),
                  iconColor:
                      ColorScheme.fromSeed(
                        seedColor: V.colors.wechatGreen,
                        brightness: Theme.of(context).brightness,
                      ).primary,
                  textColor:
                      ColorScheme.fromSeed(
                        seedColor: V.colors.wechatGreen,
                        brightness: Theme.of(context).brightness,
                      ).primary,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed(
                      AppsPage.route,
                      arguments: AppUtils.setNavValue({
                        AppsPage.pageArgument: AppsPage.wechat,
                        AppsPage.exhibitArgumgent: false,
                      }),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                return ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.access_time),
                  title: Text('时钟'),
                  iconColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed(
                      AppsPage.route,
                      arguments: AppUtils.setNavValue({
                        AppsPage.pageArgument: AppsPage.clock,
                        AppsPage.exhibitArgumgent: false,
                      }),
                    );
                  },
                );
              },
            ),
            Builder(
              builder: (context) {
                return ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(Icons.calculate),
                  title: Text('计算器'),
                  iconColor: Theme.of(context).colorScheme.primary,
                  textColor: Theme.of(context).colorScheme.primary,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    Navigator.of(context).pushNamed(
                      AppsPage.route,
                      arguments: AppUtils.setNavValue({
                        AppsPage.pageArgument: AppsPage.calculator,
                        AppsPage.exhibitArgumgent: false,
                      }),
                    );
                  },
                );
              },
            ),
            Offstage(
              offstage: kReleaseMode,
              child: Builder(
                builder: (context) {
                  return ListTile(
                    style: ListTileStyle.drawer,
                    leading: const Icon(Icons.share_location),
                    title: Text('单页展示测试'),
                    iconColor: Theme.of(context).colorScheme.outline,
                    textColor: Theme.of(context).colorScheme.outline,
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('单页展示测试'),
                            content: Text('微信小程序朋友圈分享单页模式页面, 仅用于Debug.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                    ExhibitPage.route,
                                    arguments: AppUtils.setNavValue({
                                      'showBack': true,
                                    }),
                                  );
                                },
                                child: Text('确定'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        centerTitle: true,
        title: NavTitle(navController: _navController),
      ),
      bottomNavigationBar: NavBar(navController: _navController),
      body: NavHost(navController: _navController),
    );
  }
}
