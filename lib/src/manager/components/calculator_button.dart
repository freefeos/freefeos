part of '../manager.dart';

/// 计算器按钮样式
enum CalculatorButtonStyle {
  number, //数字键
  normal, //运算符号键
}

/// 计算器按钮类型
enum CalculatorButtonType {
  text, // 文本按钮
  icon, // 图标按钮
}

/// 计算器按钮内容
enum CalculatorButtonContent {
  /// 数字0
  zero(type: CalculatorButtonType.text, text: '0'),

  /// 数字1
  one(type: CalculatorButtonType.text, text: '1'),

  /// 数字2
  two(type: CalculatorButtonType.text, text: '2'),

  /// 数字3
  three(type: CalculatorButtonType.text, text: '3'),

  /// 数字4
  four(type: CalculatorButtonType.text, text: '4'),

  /// 数字5
  five(type: CalculatorButtonType.text, text: '5'),

  /// 数字6
  six(type: CalculatorButtonType.text, text: '6'),

  /// 数字7
  seven(type: CalculatorButtonType.text, text: '7'),

  /// 数字8
  eight(type: CalculatorButtonType.text, text: '8'),

  /// 数字9
  nine(type: CalculatorButtonType.text, text: '9'),

  /// 加法
  add(type: CalculatorButtonType.text, text: '+'),

  /// 减法
  subtract(type: CalculatorButtonType.text, text: '-'),

  /// 乘法
  multiply(type: CalculatorButtonType.text, text: 'x'),

  /// 除法
  divide(type: CalculatorButtonType.text, text: '÷'),

  /// 等于
  equal(type: CalculatorButtonType.text, text: '='),

  /// 清除
  clear(type: CalculatorButtonType.text, text: 'C'),

  /// 删除
  backspace(type: CalculatorButtonType.icon, icon: Icons.backspace_outlined),

  /// 百分号
  percent(type: CalculatorButtonType.icon, icon: Icons.percent),

  /// 小数点
  point(type: CalculatorButtonType.text, text: '.'),

  /// 历史记录
  history(type: CalculatorButtonType.icon, icon: Icons.history);

  final CalculatorButtonType type;

  /// 按钮文本
  final String? text;

  /// 按钮图标
  final IconData? icon;

  /// 计算器按钮内容
  const CalculatorButtonContent({required this.type, this.text, this.icon});
}

/// 计算器按钮
class CalculatorButton extends StatelessWidget {
  const CalculatorButton({
    super.key,
    required this.content,
    required this.onExec,
    required this.style,
  });

  final CalculatorButtonStyle style;
  final CalculatorButtonContent content;
  final CalculatorExecCallback onExec;

  Color getForegroundColor(BuildContext context) {
    switch (style) {
      case CalculatorButtonStyle.number:
        return Theme.of(context).brightness == Brightness.light
            ? Colors.black
            : Colors.white;
      case CalculatorButtonStyle.normal:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Widget getContent(BuildContext context) {
    switch (content.type) {
      case CalculatorButtonType.text:
        return Text(
          content.text!,
          style: TextStyle(fontSize: 25, color: getForegroundColor(context)),
        );
      case CalculatorButtonType.icon:
        return Icon(content.icon, size: 25, color: getForegroundColor(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child: TextButton(
          onPressed: () => onExec(content),
          style: TextButton.styleFrom(padding: EdgeInsets.all(25)),
          child: getContent(context),
        ),
      ),
    );
  }
}
