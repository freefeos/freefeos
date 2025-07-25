part of '../../miniprogram.dart';

abstract interface class ICalculatorViewModel {
  /// 计算器执行计算
  void computing(CalculatorButtonContent content);

  /// 计算器清理历史记录
  Future<void> clearHistory();

  /// 计算器加载历史记录
  Future<void> loadHistory();

  /// 计算器获取历史记录
  List<String> get getHistory;

  /// 计算器获取当前输入的数字
  String get getDisplayText;

  /// 计算器获取计算结果
  String get getOutput;

  bool get isShowCalculator;
}
