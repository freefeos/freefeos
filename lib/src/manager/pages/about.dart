part of '../manager.dart';

final class AboutPage extends UiPage {
  const AboutPage({super.key});

  static const RouteName route = '/about';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于应用'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsPage.route),
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          FilledButton(
            onPressed: () => Navigator.of(
              context,
            ).popUntil(ModalRoute.withName(IndexPage.route)),
            child: Text('进入应用'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pushNamed(ManagerPage.route),
            child: Text('管理器'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pushNamed(DetailsPage.route),
            child: Text('详细信息'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsPage.route),
            child: Text('设置'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(LicensesPage.route),
            child: Text('开放源代码许可'),
          ),
        ],
      ),
    );
  }
}
