part of '../../manager.dart';

final class ClockScreen extends UiScreen {
  const ClockScreen({super.key, required super.title, required super.index});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(
                style: HeaderStyle.clock,
                showBack:
                    AppUtils.getNavValue(context, AppsPage.exhibitArgumgent) ==
                    true,
              ),
              Card.filled(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  leading: ClockView(),
                  title: TextClock(),
                  subtitle: Row(
                    children: [
                      Icon(Icons.circle, color: Colors.red, size: 10),
                      Text("时针"),
                      SizedBox(width: 12),
                      Icon(Icons.circle, color: Colors.green, size: 10),
                      Text("分针"),
                      SizedBox(width: 12),
                      Icon(Icons.circle, color: Colors.blue, size: 10),
                      Text("秒针"),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  top: 8,
                  right: 16,
                  bottom: 16,
                ),
                child: Footer(style: FooterStyle.clock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
