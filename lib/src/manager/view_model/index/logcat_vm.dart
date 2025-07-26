part of '../../manager.dart';

/// 日志ViewModel实现类
final class LogcatViewModel with ViewModel implements ILogcatViewModel {
  LogcatViewModel();

  final ListQueue<RenderedEvent> _renderedBuffer = ListQueue();
  List<RenderedEvent> _filteredBuffer = [];

  @override
  Future<void> init({
    required bool isDark,
    required OSAbility ability,
    required VoidCallback showTips,
  }) async {
    _renderedBuffer.clear();
    for (var event in EventBuffer.outputEventBuffer) {
      final IAnsiParser parser = AnsiParser(
        isDark: isDark,
        copy: (text) {
          ability.setClipboardData(text, showTips);
        },
      );
      final String text = event.lines.join('\n');
      int currentId = 0;
      parser.parse(text);
      _renderedBuffer.add(
        RenderedEvent(
          currentId++,
          event.level,
          TextSpan(children: parser.getSpans),
          text.toLowerCase(),
        ),
      );
    }
    _filteredBuffer =
        _renderedBuffer
            .where((it) => it.level.value >= Level.CONFIG.value)
            .toList();
  }

  /// 获取日志列表长度
  @override
  int? get getItemCount => _filteredBuffer.length;

  /// 获取日志内容
  @override
  InlineSpan getTextSpan(int index) => _filteredBuffer[index].span;

  /// 获取日志key
  @override
  String getKey(int index) => _filteredBuffer[index].id.toString();

  /// 获取日志级别
  @override
  Level getLevel(int index) => _filteredBuffer[index].level;

  /// 是否是顶部
  @override
  bool isTop(int index) {
    return _filteredBuffer.isNotEmpty && index == 0;
  }

  /// 是否是底部
  @override
  bool isBottom(int index) {
    return _filteredBuffer.isNotEmpty && index == _filteredBuffer.length - 1;
  }
}
