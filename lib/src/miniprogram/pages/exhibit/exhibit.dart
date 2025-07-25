part of '../../miniprogram.dart';

final class ExhibitPage extends UiPage {
  const ExhibitPage({super.key});

  static const RouteName route = '/exhibit';

  @override
  State<ExhibitPage> createState() => _ExhibitPageState();
}

class _ExhibitPageState extends State<ExhibitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        title: '单页模式',
        index: 0,
        isExhibit: true,
        label: '单页模式',
        icon: Icons.wechat,
        selectedIcon: Icons.wechat,
      ),
    );
  }
}
