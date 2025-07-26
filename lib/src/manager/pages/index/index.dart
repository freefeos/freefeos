part of '../../manager.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  static const RouteName route = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return CapsuleButton(
      firstIcon: Icons.more_horiz,
      lastIcon: Icons.adjust,
      firstTooltip: '',
      lastTooltip: '',
      onFirstTap: () {
        Navigator.of(context).pushNamed(ManagerPage.route);
      },
      onLastTap: () {},
      child: Consumer<OSAbility>(
        builder: (context, ability, child) {
          return ability.getChild ?? const Placeholder();
        },
      ),
    );
  }
}
