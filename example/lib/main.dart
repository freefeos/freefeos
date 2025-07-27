import 'package:flutter/material.dart';
// 导入 FreeFEOS 库
import 'package:freefeos/freefeos.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(),
      },
      // 关键在这里, 一行代码接入 FreeFEOS 库
      builder: FreeFEOS.builder,
      theme: ThemeData(
        brightness: MediaQuery.platformBrightnessOf(context),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: MediaQuery.platformBrightnessOf(context),
        ),
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
        title: const Text('FreeFEOS Demo'),
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
class CapsulePlaceholder extends StatelessWidget {
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
