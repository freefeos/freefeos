part of '../manager.dart';

/// 文本时钟组件
final class TextClock extends UiStatefulComponent {
  const TextClock({super.key});

  @override
  State<TextClock> createState() => _TextClockState();
}

class _TextClockState extends State<TextClock> {
  /// 当前时间
  String _currentTime = '00:00:00';

  /// 定时器
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    timer = Timer.periodic(Duration(seconds: 1), (timer) => _updateTime());
  }

  @override
  void dispose() {
    timer.cancel(); // 销毁时取消定时器
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      DateTime now = DateTime.now();
      String hour = now.hour.toString().padLeft(2, '0');
      String minute = now.minute.toString().padLeft(2, '0');
      String second = now.second.toString().padLeft(2, '0');
      String formattedTime = '$hour:$minute:$second';
      _currentTime = formattedTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentTime, style: Theme.of(context).textTheme.headlineLarge);
  }
}
