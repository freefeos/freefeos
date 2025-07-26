part of '../manager.dart';

/// Shell构建器
final class Shell extends UiComponent {
  const Shell({super.key, required this.builder});

  /// Shell构建器
  final ShellBuilder builder;

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  _ShellState();

  /// AppBar主题
  AppBarTheme _appBarTheme = AppBarTheme();

  /// 颜色模式
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);

  /// 导航器观察者
  NavigatorObserver _navigatorObserver = NavigatorObserver();

  @override
  void initState() {
    super.initState();
    // 系统能力
    final OSAbility ability = Provider.of<OSAbility>(context, listen: false);
    // 获取应用栏主题
    _appBarTheme = ability.getAppBarTheme;
    // 获取颜色模式
    _themeMode.value = ability.getThemeMode;
    // 获取导航器观察者
    _navigatorObserver = ability.getNavigatorObserver;
    // 添加颜色模式变更监听器
    ability.addThemeModeChangeListener(() {
      _themeMode.value = ability.getThemeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, themeMode, child) {
        return Container(
          child: widget.builder(
            context,
            _appBarTheme,
            themeMode,
            _navigatorObserver,
          ),
        );
      },
    );
  }
}
