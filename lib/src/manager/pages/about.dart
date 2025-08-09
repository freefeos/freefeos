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
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            leading: const FlutterLogo(),
            title: Text('appName'),
            subtitle: Text('appVersionName'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
            contentPadding: const EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
              right: 16.0,
            ),
            onTap: () => Navigator.of(context).pushNamed(DetailsPage.route),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 4.0),
                    child: FilledButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).popUntil(ModalRoute.withName(IndexPage.route)),
                      child: Text('进入应用'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(ManagerPage.route),
                      child: Text('管理器'),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Card.filled(
          //   margin: const EdgeInsets.only(
          //     left: 16,
          //     top: 8,
          //     bottom: 8,
          //     right: 16,
          //   ),
          //   child: ListTile(),
          // ),
          Card.filled(
            margin: const EdgeInsets.only(
              left: 16,
              top: 8,
              bottom: 2,
              right: 16,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(12.0),
                bottom: Radius.circular(6.0),
              ),
            ),
            child: Tooltip(
              message: '设置',
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('设置'),
                onTap: () =>
                    Navigator.of(context).pushNamed(SettingsPage.route),
                trailing: const Icon(Icons.keyboard_arrow_right),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.0),
                    bottom: Radius.circular(6.0),
                  ),
                ),
              ),
            ),
          ),
          Card.filled(
            margin: const EdgeInsets.only(
              left: 16,
              top: 2,
              bottom: 16,
              right: 16,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(6.0),
                bottom: Radius.circular(12.0),
              ),
            ),
            child: Tooltip(
              message: '开放源代码许可',
              child: ListTile(
                leading: Icon(Icons.add),
                title: Text('开放源代码许可'),
                onTap: () =>
                    Navigator.of(context).pushNamed(LicensesPage.route),
                trailing: const Icon(Icons.keyboard_arrow_right),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.0),
                    bottom: Radius.circular(12.0),
                  ),
                ),
              ),
            ),
          ),

          // FilledButton(
          //   onPressed: () =>
          //       Navigator.of(context).pushNamed(SettingsPage.route),
          //   child: Text('设置'),
          // ),
          // FilledButton(
          //   onPressed: () =>
          //       Navigator.of(context).pushNamed(LicensesPage.route),
          //   child: Text('开放源代码许可'),
          // ),
        ],
      ),
    );
  }
}
