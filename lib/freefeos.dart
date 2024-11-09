/// 插件注册和API导出
library;

import 'package:flutter/widgets.dart';

import 'src/entry/entry.dart';
import 'src/interface/platform_interface.dart';
import 'src/interface/system_interface.dart';
import 'src/platform/method_channel.dart';
import 'src/plugin/plugin_runtime.dart';
import 'src/type/types.dart';

/// 平台插件注册
///
/// 插件注册由Flutter框架接管, 请勿手动注册.
/// 插件注册由Flutter框架接管, 请勿手动注册.
/// 插件注册由Flutter框架接管, 请勿手动注册.
///
/// 重要的事情说三遍!
///
/// 来来来, 让我看看到底是谁不信邪, 自己又注册一遍?
/// 不要问我注册器是不是公开访问的? 废话! 不公开插件怎么被Flutter注册?
/// 虽然说不听老人言开心好几年, 但是你不听确实会有不可预测的情况出现, 为了代码稳定起见还是别不信邪了.
/// 实在不信邪也可以试试, 崩了跟我可无关. ╮(╯_╰)╭
final class FreeFEOSRegister {
  const FreeFEOSRegister();

  /// 注册插件
  ///
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  /// 插件注册由Flutter框架接管, 请勿手动注册.
  ///
  /// 重要的事情说三遍!
  static void registerWith() {
    FreeFEOSInterface.instance = SystemEntry();
    FreeFEOSPlatform.instance = MethodChannelFreeFEOS();
  }
}

/// 插件
///
/// 示例代码
///
/// ```dart
/// final class ExamplePlugin implements FreeFEOSPlugin {
///   ExamplePlugin();
///
///   /// "ExampleAuthor"为作者信息,替换为你自己的名字即可,通过[pluginAuthor]方法定义.
///   @override
///   String get pluginAuthor => 'ExampleAuthor';
///
///   /// "example_channel"为插件的通道,可以理解为插件的唯一标识,我们通常使用全小写英文字母加下划线的命名方式,通过[pluginChannel]方法定义.
///   @override
///   String get pluginChannel => 'example_channel';
///
///   /// "Example description"为插件的描述,通过[pluginDescription]方法定.
///   @override
///   String get pluginDescription => 'Example description';
///
///   /// "Example Plugin"为插件的名称,通过[pluginName]方法定义.
///   @override
///   String get pluginName => 'ExamplePlugin';
///
///   /// 插件的用户界面
///   @override
///   Widget pluginWidget(BuildContext context) {
///     return const Center(
///       child: Text('Hello, World!'),
///     );
///   }
///
///   /// [onMethodCall]方法为插件的方法调用.
///   @override
///   Future<dynamic> onMethodCall(
///     String method, [
///     dynamic arguments,
///   ]) async {
///     switch (method) {
///       case 'add':
///         var arg = arguments['arg'];
///         return '$arg world';
///       default:
///         return await null;
///     }
///   }
/// }
/// ```
typedef FreeFEOSPlugin = RuntimePlugin;

/// 插件代码执行器
///
/// 用于执行 [FreeFEOSPlugin] 插件代码的执行器.
///
/// 具体用法:
///
/// 1.首先编写一个应用程序全局类,
/// 编写FreeFEOSExec接口, 这里使用返回空作为容错处理.
/// 如果在接下来的初始化API出现异常将不执行插件代码返回空.
///
/// ```dart
/// class Global {
///   const Global();
///
///   ......
///
///   static FreeFEOSExec exec = (
///     String channel,
///     String method, [
///     dynamic arguments,
///   ]) async {
///     return await null;
///   };
///
///   ......
///
/// }
/// ```
///
/// 2.随后在用于启动App的FreeFEOSLauncher的initApi
/// 函数中将exec参数赋值给Global.exec.
///
/// ```dart
/// final launch = FreeFEOSLauncher(
///   runner: (app) async => runApp(app),
///   plugins: () => [ExamplePlugin()],
///   initApi: (exec) async {
///     Global.exec = exec;
///   },
/// );
/// ```
///
/// 3.最后在代码中使用Global.exec()达到执行代码的目的.
///
/// ```dart
/// dynamic result = await Global.exec(
///   'example_channel',
///   'add',
///   {'arg': 'hello'},
/// );
/// ```
///
/// 实在不明白该如何使用的, 可以读一下示例程序的源码.
/// 在该文件最下方有示例代码链接.
typedef FreeFEOSExec = MethodExecer;

/// FreeFEOS 启动器
final class FreeFEOSLauncher {
  const FreeFEOSLauncher._({
    required this.runner,
    required this.plugins,
    required this.initApi,
    required this.enabled,
  });

  final AppRunner? runner;
  final PluginList? plugins;
  final ApiBuilder? initApi;
  final bool? enabled;

  /// FreeFEOS 启动器
  ///
  /// [FreeFEOSLauncher] 的工厂构造函数, 用于构建启动应用的应用启动器.</br>
  /// 启动器需要使用异步功能, 请将main入口函数的void类型改为Future<void>并添加async标签转为异步函数.</br>
  ///
  /// * [runner] 为启动应用的函数, 如果传入null默认为 [runApp].
  /// * [plugins] 为应用的插件, 如果传入null默认为空列表.
  /// * [initApi] 为初始化API的函数, [exec] 插件方法执行接口.
  /// * [enabled] 为框架使能, 如果传入null默认为false.
  ///
  /// 示例代码
  /// ```dart
  /// final launch = FreeFEOSLauncher(
  ///   runner: (app) async => runApp(app),
  ///   plugins: <FreeFEOSPlugin>[ExamplePlugin()],
  ///   initApi: (exec) async => Global.exec = exec,
  ///   enabled: true,
  /// );
  /// await launch(const MyApp());
  /// ```
  factory FreeFEOSLauncher({
    Future<void> Function(Widget app)? runner,
    List<FreeFEOSPlugin>? plugins,
    Future<void> Function(
      Future<dynamic> Function(
        String channel,
        String method, [
        dynamic arguments,
      ]) exec,
    )? initApi,
    bool? enabled,
  }) {
    return FreeFEOSLauncher._(
      runner: runner,
      plugins: plugins,
      initApi: initApi,
      enabled: enabled,
    );
  }

  /// 启动应用
  ///
  /// [app] 传入App的根Widget
  ///
  /// FreeFEOSRunner的可调用对象 (call函数),
  /// 可调用对象官方文档https://dart.dev/language/callable-objects
  Future<void> call(Widget app) {
    return FreeFEOSInterface.instance.runFreeFEOSApp(
      runner: runner,
      plugins: plugins,
      initApi: initApi,
      enabled: enabled,
      app: app,
      error: null,
    );
  }
}

/// 最简实现
///
/// [app] 传入App的根Widget
Future<void> runFFApp(Widget app) => FreeFEOSLauncher(enabled: true)(app);

/// 此文件为导出的, 可被外部访问的公共API接口, 但 [FreeFEOSBase] 类除外.
/// 有关API的完整示例代码, 请参阅 https://pub.dev/packages/freefeos/example
