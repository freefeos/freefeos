part of '../../manager.dart';

final class IndexPage extends UiPage {
  const IndexPage({super.key});

  static const RouteName route = '/';

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  DateTime? _lastBackPressTime;

  Future<bool> _shouldExit() async {
    final now = DateTime.now();
    if (_lastBackPressTime == null ||
        now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('再按一次退出应用')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
        builder: (context) => CapsuleButton(
          firstIcon: Icons.more_horiz,
          lastIcon: Icons.adjust,
          firstTooltip: '',
          lastTooltip: '',
          onFirstTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheet(
                  showDragHandle: true,
                  onClosing: () {},
                  builder: (context) {
                    return FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(ManagerPage.route);
                      },
                      child: Text('Manager'),
                    );
                  },
                );
              },
            );
          },
          onLastTap: () async {
            final shouldExit = await _shouldExit();
            if (shouldExit) {
              // SystemNavigator.pop();
            }
          },
          child: Consumer<OSAbility>(
            builder: (context, ability, child) {
              return ability.getChild ?? child!;
            },
            child: const Placeholder(),
          ),
        ),
      ),
    );
  }
}
