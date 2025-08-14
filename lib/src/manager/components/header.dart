part of '../manager.dart';

enum HeaderStyle { ecosedkit, wechat, clock, calculator }

final class Header extends UiStatefulComponent {
  const Header({
    super.key,
    required this.style,
    this.showBack = false,
    this.showCalculator = false,
    this.displayText,
    this.outputText,
  });

  final HeaderStyle style;
  final bool showBack;
  final bool showCalculator;
  final String? displayText;
  final String? outputText;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
  }

  String getTitle(BuildContext context) {
    switch (widget.style) {
      case HeaderStyle.ecosedkit:
        return AppLocalizations.of(context).componentHeaderTitleEcosedKit;
      case HeaderStyle.wechat:
        return AppLocalizations.of(context).componentHeaderTitleWeChat;
      case HeaderStyle.clock:
        return AppLocalizations.of(context).componentHeaderTitleClock;
      case HeaderStyle.calculator:
        return AppLocalizations.of(context).componentHeaderTitleCalculator;
    }
  }

  IconData get getIconData {
    switch (widget.style) {
      case HeaderStyle.ecosedkit:
        return Icons.keyboard_command_key;
      case HeaderStyle.wechat:
        return Icons.wechat;
      case HeaderStyle.clock:
        return Icons.access_time;
      case HeaderStyle.calculator:
        return Icons.calculate;
    }
  }

  Color getColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  int get getCount {
    final bool isCalculator = widget.style == HeaderStyle.calculator;
    final bool showCalculator = widget.showCalculator;
    if (!isCalculator) {
      return 0;
    } else {
      if (showCalculator) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: <Widget>[
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Offstage(
                  offstage: !widget.showBack,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FloatingActionButton.small(
                      elevation: 0.0,
                      focusElevation: 0.0,
                      hoverElevation: 0.0,
                      highlightElevation: 0.0,
                      disabledElevation: 0.0,
                      tooltip: 'Back',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(getIconData, size: 38, color: getColor(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    getTitle(context),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: getColor(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.displayText ?? '',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 12),
                      Text(
                        widget.outputText ?? '',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ][getCount],
      ),
    );
  }
}
