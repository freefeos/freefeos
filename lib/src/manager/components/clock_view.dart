part of '../manager.dart';

final class ClockView extends UiStatefulComponent {
  const ClockView({super.key});

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() {}),
    ); // 每秒更新一次状态，重新绘制
  }

  @override
  void dispose() {
    _timer.cancel(); // 销毁时，取消定时器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomPaint(
        painter: ClockPainter(
          dateTime: DateTime.now(),
          bezelColor: Theme.of(context).colorScheme.primary,
        ), // 使用自定义的ClockPainter进行绘制
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  const ClockPainter({required this.dateTime, required this.bezelColor});

  final DateTime dateTime;
  final Color bezelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2; // 计算画布中心点的X坐标
    final centerY = size.height / 2; // 计算画布中心点的Y坐标
    final center = Offset(centerX, centerY); // 画布中心点
    final radius = min(centerX, centerY); // 计算画布的半径，取宽和高中的最小值

    final paint = Paint()..strokeWidth = 2; // 创建画笔，设置笔触宽度为10

    // 画表盘
    paint.color = bezelColor; // 设置画笔颜色为黑色
    paint.style = PaintingStyle.stroke; // 设置画笔样式为描边
    canvas.drawCircle(center, radius, paint); // 在画布上画一个圆形的表盘

    // 画刻度
    const tickWidth = 2.0; // 刻度线的宽度
    paint.strokeWidth = tickWidth; // 设置画笔宽度为刻度线的宽度
    for (var i = 0; i < 4; i++) {
      // 循环画4个刻度线
      var tickLength = 5.0; // 刻度线长度
      var tickX1 = centerX + radius * cos(i * 90 * pi / 180); // 计算刻度线起点的X坐标
      var tickY1 = centerY + radius * sin(i * 90 * pi / 180); // 计算刻度线起点的Y坐标
      var tickX2 =
          centerX +
          (radius - tickLength) * cos(i * 90 * pi / 180); // 计算刻度线终点的X坐标
      var tickY2 =
          centerY +
          (radius - tickLength) * sin(i * 90 * pi / 180); // 计算刻度线终点的Y坐标
      canvas.drawLine(
        Offset(tickX1, tickY1),
        Offset(tickX2, tickY2),
        paint,
      ); // 在画布上画刻度线
    }

    // 画时针
    final hourHandX =
        centerX +
        radius *
            0.4 *
            cos(
              (dateTime.hour * 30 + dateTime.minute * 0.5 - 90) * pi / 180,
            ); // 计算时针的X坐标
    final hourHandY =
        centerY +
        radius *
            0.4 *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5 - 90) * pi / 180);
    paint.color = Colors.red; // 设置画笔颜色为红色
    canvas.drawLine(center, Offset(hourHandX, hourHandY), paint); // 在画布上画时针

    // 画分针
    final minuteHandX =
        centerX +
        radius *
            0.6 *
            cos(
              (dateTime.minute * 6 + dateTime.second * 0.1 - 90) * pi / 180,
            ); // 计算分针的X坐标
    final minuteHandY =
        centerY +
        radius *
            0.6 *
            sin(
              (dateTime.minute * 6 + dateTime.second * 0.1 - 90) * pi / 180,
            ); // 计算分针的Y坐标
    paint.color = Colors.green; // 设置画笔颜色为绿色
    canvas.drawLine(center, Offset(minuteHandX, minuteHandY), paint); // 在画布上画分针

    // 画秒针
    final secondHandX =
        centerX +
        radius * 0.8 * cos((dateTime.second * 6 - 90) * pi / 180); // 计算秒针的X坐标
    final secondHandY =
        centerY +
        radius * 0.8 * sin((dateTime.second * 6 - 90) * pi / 180); // 计算秒针的Y坐标
    paint.color = Colors.blue; // 设置画笔颜色为蓝色
    canvas.drawLine(center, Offset(secondHandX, secondHandY), paint); // 在画布上画秒针
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return dateTime != oldDelegate.dateTime; // 当时间改变时，重新绘制
  }
}
