import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:freefeos/freefeos.dart'; // 导入 FreeFEOS 库
import 'package:multi_builder/multi_builder.dart';

void main() => runApp(const MyApp());
// void main() => runApp(MaterialApp(builder: FreeFEOS.builder));

final ValueNotifier<bool> freefeosenable = ValueNotifier(false);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DevicePreview(
      enabled: false,
      builder: (context) => MaterialApp(
        routes: {
          '/': (context) => const HomePage(),
          '/details': (context) => const DetailsPage(),
        },
        builder: [
          // 生命周期监听器, 用于调试 device_preview 的 bug, 与 freefeos 无关.
          // 日志会显示 initState 被执行两次, 然后 dispose, 然后继续执行. 逆天.
          LifecycleListener.builder,
          // bug: https://github.com/aloisdeniel/flutter_device_preview/issues/252
          // device_preview 的逆天 Bug, 导致父级 Widget 生命周期错乱, initState会执行两次,
          // 而且会在 dispose() 后继续执行代码, 导致抛出异常.
          // 如果与 device_preview 同时使用, 请将 freefeos 置于其后方.
          DevicePreview.appBuilder,
          // 关键在这里, 一行代码接入 FreeFEOS 库
          FreeFEOS.builder(enabled: ValueNotifier(false)),
        ].toBuilder, // 多构造器
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purple,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        locale: DevicePreview.locale(context),
        // 为了与 device_preview 兼容, 需要将 useInheritedMediaQuery 设置为 true.
        // ignore: deprecated_member_use
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [CapsulePlaceholder()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: const TextStyle(fontSize: 32)),
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed('/details'),
              child: const Text('路由测试'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('路由测试'),
        actions: const [CapsulePlaceholder()],
      ),
      body: Center(
        child: FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('返回'),
        ),
      ),
    );
  }
}

/// 胶囊按钮占位符示例, 用于顶部应用栏Actino按钮占位
final class CapsulePlaceholder extends StatelessWidget {
  const CapsulePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    /// 胶囊按钮宽度为87.0, 胶囊按钮高度为32.0
    /// 胶囊按钮填充数值计算方式:
    /// (顶部应用栏默认高度 - 胶囊按钮高度) / 2
    /// 由于顶部应用栏默认高度为56, 所以原式为:
    /// (56.0 - 32.0) / 2 = 12.0
    /// 所以 width=87.0, height=32.0, padding=12.0
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: SizedBox(width: 87.0, height: 32.0),
    );
  }
}

/// 生命周期监听器, 用于调试 device_preview 的 bug, 与 freefeos 无关.
final class LifecycleListener extends StatefulWidget {
  const LifecycleListener({super.key, required this.child});

  final Widget? child;

  static TransitionBuilder get builder {
    return (context, child) => LifecycleListener(child: child);
  }

  @override
  State<LifecycleListener> createState() => _LifecycleListenerState();
}

final class _LifecycleListenerState extends State<LifecycleListener> {
  @override
  void initState() {
    super.initState();
    debugPrint("initState#${DateTime.now()}");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("didChangeDependencies#${DateTime.now()}");
  }

  @override
  void didUpdateWidget(covariant LifecycleListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint("didUpdateWidget#${DateTime.now()}");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose#${DateTime.now()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.child);
  }
}
