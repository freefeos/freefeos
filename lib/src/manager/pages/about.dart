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
      appBar: AppBar(title: Text('About')),
      body: Column(
        children: [
          FilledButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: false,
            ).pushNamed(LicensesPage.route),
            child: Text('开放源代码协议'),
          ),
        ],
      ),
    );
  }
}
