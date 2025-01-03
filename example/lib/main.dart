import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freefeos/freefeos.dart';

/// 入口函数
Future<void> main() async {
  // 使用运行器启动应用
  await FreeFEOSLauncher(
    plugins: <FreeFEOSPlugin>[ExamplePlugin()],
    initApi: (exec) async => Global.exec = exec,
  )(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Global.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: MediaQuery.platformBrightnessOf(
            context,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ValueListenableBuilder(
              valueListenable: Global.counter,
              builder: (context, value, child) {
                return Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: false, // 不要使用根导航
              ).pushNamed('/details'),
              child: const Text('DetailsPage'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Global.exec(
            Global.channel,
            Global.add,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('DetailsPage'),
            FilledButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: false, // 不要使用根导航
              ).pop(),
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Global全局类
class Global {
  const Global();

  static FreeFEOSExec exec = (
    String channel,
    String method, [
    dynamic arguments,
  ]) async {
    final example = ExamplePlugin();
    if (channel == example.pluginChannel) {
      try {
        example.invoke(method, arguments);
      } on Exception {
        rethrow;
      }
    }
    return await null;
  };

  /// 应用名称
  static const String appName = 'FreeFEOS 示例应用';
  static const String appDescription = '演示如何使用freefeos';
  static const String developerName = 'wyq0918dev';
  static final Uri officialWebsite = Uri.parse('');
  static final Uri feedbackWebsite = Uri.parse('');

  /// 计数
  static final ValueNotifier<int> counter = ValueNotifier(0);

  /// 计数器
  static const String add = 'add';
  static const String channel = 'example_channel';
}

final class ExamplePlugin implements FreeFEOSPlugin {
  ExamplePlugin();

  /// "ExampleAuthor"为作者信息,替换为你自己的名字即可,通过[pluginAuthor]方法定义.
  @override
  String get pluginAuthor => 'ExampleAuthor';

  /// "example_channel"为插件的通道,可以理解为插件的唯一标识,我们通常使用全小写英文字母加下划线的命名方式,通过[pluginChannel]方法定义.
  @override
  String get pluginChannel => Global.channel;

  /// "Example description"为插件的描述,通过[pluginDescription]方法定.
  @override
  String get pluginDescription => 'Example description';

  /// "Example Plugin"为插件的名称,通过[pluginName]方法定义.
  @override
  String get pluginName => 'ExamplePlugin';

  /// 插件的用户界面
  @override
  Widget pluginWidget(BuildContext context) {
    return const Center(
      child: Text('Hello, World!'),
    );
  }

  /// [onMethodCall]方法为插件的方法调用.
  @override
  Future<dynamic> onMethodCall(
    String method, [
    dynamic arguments,
  ]) async {
    switch (method) {
      case Global.add:
        Global.counter.value++;
        return Global.counter.value;
      default:
        return await null;
    }
  }

  Future<dynamic> invoke(
    String method, [
    dynamic arguments,
  ]) async {
    return await onMethodCall(
      method,
      arguments,
    );
  }
}
