part of '../../manager.dart';

/// 日志页面布局
final class LogcatScreen extends UiScreen {
  const LogcatScreen({
    super.key,
    required super.title,
    required super.index,
    required super.label,
    required super.icon,
    required super.selectedIcon,
  });

  @override
  State<LogcatScreen> createState() => _LogcatScreenState();
}

class _LogcatScreenState extends State<LogcatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    setState(() {
      Provider.of<LogcatViewModel>(context, listen: false).init(
        isDark: Theme.of(context).brightness == Brightness.dark,
        ability: Provider.of<OSAbility>(context, listen: false),
        showTips: _showTips,
      );
    });
  }

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
        child: Consumer<LogcatViewModel>(
          builder: (context, logcat, _) {
            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: logcat.getItemCount,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      top: logcat.isTop(index) ? 16 : 0,
                      right: 16,
                      bottom: logcat.isBottom(index) ? 16 : 0,
                    ),
                    title: Text.rich(
                      logcat.getTextSpan(index),
                      key: Key(logcat.getKey(index)),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppUtils.level2Color(
                          logcat.getLevel(index),
                          context,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  /// 显示复制提示
  void _showTips() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).indexLogcatItemCopyTips),
        action: SnackBarAction(
          label: AppLocalizations.of(context).indexLogcatSnackBarAction,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
