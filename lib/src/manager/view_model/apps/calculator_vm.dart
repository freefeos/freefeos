part of '../../manager.dart';

final class CalculatorViewModel with ViewModel implements ICalculatorViewModel {
  /// 计算结果
  String _output = "0";

  /// 数字1
  double _num1 = 0;

  /// 数字2
  double _num2 = 0;

  /// 运算符
  OperatorType _operator = OperatorType.nothing;

  /// 第一行的显示文本
  String _displayText = '';

  /// 计算器历史记录
  List<String> _history = [];

  bool showCalculator = false;

  /// Logcat 标签
  static const String _tag = 'CalculatorViewModel';

  @override
  void computing(CalculatorButtonContent content) {
    switch (content) {
      case CalculatorButtonContent.clear:
        showCalculator = false;
        _output = 0.toString();
        _num1 = 0;
        _num2 = 0;
        _operator = OperatorType.nothing;
        _displayText = '';
        break;
      case CalculatorButtonContent.add:
      case CalculatorButtonContent.subtract:
      case CalculatorButtonContent.multiply:
      case CalculatorButtonContent.divide:
        showCalculator = true;
        _num1 = double.parse(_output);
        switch (content) {
          case CalculatorButtonContent.add:
            _operator = OperatorType.add;
            break;
          case CalculatorButtonContent.subtract:
            _operator = OperatorType.subtract;
            break;
          case CalculatorButtonContent.multiply:
            _operator = OperatorType.multiply;
            break;
          case CalculatorButtonContent.divide:
            _operator = OperatorType.divide;
            break;
          default:
            _operator = OperatorType.nothing;
        }
        _displayText = '$_output ${content.text}';
        _output = 0.toString();
        break;
      case CalculatorButtonContent.equal:
        showCalculator = true;
        _num2 = double.parse(_output);
        double result = 0;
        String operatorStr = '';
        switch (_operator) {
          case OperatorType.add:
            result = _num1 + _num2;
            operatorStr = CalculatorButtonContent.add.text ?? '';
            break;
          case OperatorType.subtract:
            result = _num1 - _num2;
            operatorStr = CalculatorButtonContent.subtract.text ?? '';
            break;
          case OperatorType.multiply:
            result = _num1 * _num2;
            operatorStr = CalculatorButtonContent.multiply.text ?? '';
            break;
          case OperatorType.divide:
            if (_num2 != 0) {
              result = _num1 / _num2;
            } else {
              result = double.nan; // 除数为0，返回NaN
            }
            operatorStr = CalculatorButtonContent.divide.text ?? '';
            break;
          case OperatorType.nothing:
            break;
        }
        _output = result.toString();
        // 添加历史记录
        String historyItem = "$_num1 $operatorStr $_num2 = $_output";
        _history.add(historyItem);
        _saveHistory(); // 保存历史记录
        break;
      case CalculatorButtonContent.percent:
        showCalculator = true;
        double num = double.parse(_output);
        double percentage = num / 100;
        _output = percentage.toString();
        break;
      case CalculatorButtonContent.point:
        showCalculator = true;
        if (!_output.contains(".")) {
          _output += ".";
        }
        break;
      case CalculatorButtonContent.backspace:
        showCalculator = true;
        // 处理删除逻辑
        if (_output.length > 1) {
          _output = _output.substring(0, _output.length - 1);
        } else {
          _output = 0.toString();
        }
        break;
      default:
        showCalculator = true;
        if (content.type == CalculatorButtonType.text) {
          if (_output == 0.toString()) {
            _output = content.text ?? '';
          } else {
            _output = _output + (content.text ?? '');
          }
        }
        break;
    }
  }

  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('history', _history);
    Log.d(tag: _tag, message: '已保存历史记录!');
  }

  @override
  Future<void> loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? history = prefs.getStringList('history');
    if (history != null) _history = history;
  }

  @override
  Future<void> clearHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    _history = [];
    Log.d(tag: _tag, message: '已清理历史记录!');
  }

  @override
  List<String> get getHistory => _history;

  @override
  String get getDisplayText => _displayText;

  @override
  String get getOutput => _output;

  @override
  bool get isShowCalculator => showCalculator;
}
