part of '../../miniprogram.dart';

/// 日志ViewModel接口
abstract interface class ILogcatViewModel {
  /// 初始化日志
  Future<void> init({
    required bool isDark,
    required OSAbility ability,
    required VoidCallback showTips,
  });

  /// 获取日志列表长度
  int? get getItemCount;

  /// 获取日志内容
  InlineSpan getTextSpan(int index);

  /// 获取日志key
  String getKey(int index);

  /// 获取日志级别
  Level getLevel(int index);

  /// 是否是顶部
  bool isTop(int index);

  /// 是否是底部
  bool isBottom(int index);
}
