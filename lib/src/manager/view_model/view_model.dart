import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:window_manager/window_manager.dart';

import '../../common/model/model.dart';
import '../../common/plugin/plugin_type.dart';
import '../../common/types/types.dart';
import '../../common/utils/utils.dart';
import '../../common/values/url.dart';
import '../../framework/context.dart';
import '../intl/app_localizations.dart';

abstract interface class IManagerViewModel {
  /// 附加构建上下文
  void attachBuildContext(BuildContext context);

  /// 获取应用名称
  Future<String> getAppName();

  /// 获取应用版本
  Future<String> getAppVersion();

  /// 统计普通插件数量
  String pluginCount();

  /// 获取所有普通插件的名称
  String pluginNames();

  /// 打开PubDev
  void launchPubDev();

  /// 获取插件列表
  List<PluginDetails> get getPluginDetailsList;

  /// 获取插件图标
  Widget getPluginIcon(
    BuildContext context,
    PluginDetails details,
  );

  /// 获取插件类型
  String getPluginType(
    BuildContext context,
    PluginDetails details,
  );

  /// 获取插件的提示
  String getPluginTooltip(
    BuildContext context,
    PluginDetails details,
  );

  /// 打开卡片
  void clickPlugin(
    BuildContext context,
    PluginDetails details,
    VoidCallback launchPlugin,
    VoidCallback launchAbout,
    VoidCallback showTip,
  );

  /// 最大化窗口
  void maximizeWindow();

  /// 拖动窗口
  void startDragging();

  /// 关闭窗口
  void closeWindow();

  /// 最小化窗口
  void minimizeWindow();

  /// 退出
  void exitApp();

  /// 获取当前插件的详细信息
  PluginDetails get getCurrentDetails;

  /// 获取插件界面
  PluginWidgetGetter get getPluginWidget;

  /// 获取应用根控件
  Widget get getRootWidget;

  /// 获取每日一言
  String get getPoem;
}

final class ManagerViewModel extends ContextWrapper
    with ViewModel
    implements IManagerViewModel {
  /// 构造函数
  ManagerViewModel({
    required BuildContext context,
    required this.contextAttacher,
    required this.pluginDetailsList,
    required this.pluginGetter,
    required this.pluginWidgetGetter,
    required this.runtimeChecker,
    required this.rootWidget,
  }) : super(attach: true) {
    attachBuildContext(context);
  }

  /// 上下文附加器
  final ContextAttacher contextAttacher;

  /// 插件列表
  final List<PluginDetails> pluginDetailsList;

  /// 获取插件
  final PluginGetter pluginGetter;

  /// 获取插件界面
  final PluginWidgetGetter pluginWidgetGetter;

  /// 判断是否运行时
  final RuntimeChecker runtimeChecker;

  /// 应用根控件
  final Widget rootWidget;

  /// 每日一言 - 心灵鸡汤
  /// 来源网络, 如有侵权, 联系必删.
  static const List<String> _list = [
    '不向焦虑与抑郁投降, 这个世界终会有我们存在的地方.',
    '把喜欢的一切留在身边, 这便是努力的意义.',
    '治愈、温暖, 这就是我们最终幸福的结局.',
    '我有一个梦, 也许有一天, 灿烂的阳光能照进黑暗森林.',
    '如果必须要失去, 那么不如一开始就不曾拥有.',
    '我们的终点就是与幸福同在.',
    '孤独的人不会伤害别人, 只会不断地伤害自己罢了.',
    '如果你能记住我的名字, 如果你们都能记住我的名字, 也许我或者我们, 终有一天能自由地生存着.',
    '对于所有生命来说, 不会死亡的绝望, 是最可怕的审判.',
    '我不曾活着, 又何必害怕死亡.',
    '刚出生的婴儿会哭, 那是对生的喜悦, 还是对世界的恐惧?',
    '很多人看不到未来, 其实是看到了未来.',
    '当你想要测试一块玻璃的硬度时, 这块玻璃注定要碎, 换句话说, 怀疑一旦产生, 罪名便已成立了.',
    '社会总是病态的, 越好的社会病情就越严重.',
    '在所有失去的人中, 我最怀念我自己.',
    '我是孤独大赛的第一名, 也是最后一名.',
    '敬老院的新人都是老人, 这世界的大人都是小人.',
    '这台手术很成功, 我失败的人生结束了.',
    '会不会我已经死了, 而大家都瞒着我呢?',
    '成年人的崩溃从算了开始, 计算机的崩溃从不算了开始.',
    '要么庸俗, 要么孤独.',
    '越身处底层的人越喜欢用自我牺牲来表达爱意.',
    '只有建立在利益上的关系才是最牢固的.',
    '可怜之人必有可恨之处, 可恨之人必有可悲之苦.',
    '出生牛犊不怕虎, 待到长成反怕狼.',
    '奇怪的动物都被保护起来, 奇怪的人却要遭受排挤.',
    '枪响了. 你看到谁开的枪吗? 我看不清, 他站在道德的制高点, 他在阳光下.',
    '一束光照进铁塔, 铁塔内肮脏龌龊被显现, 于是, 这束光便有了罪.',
    '人病了吃药, 社会病了吃人.',
    '友谊就像一张白纸, 一旦有了褶皱, 就再也抹不平了.',
    '我们所听到的一切都只是一个观点, 不是事实; 我们所看到的一切都是一个视角, 不是真相;',
  ];

  /// 当前插件的详细信息 [PluginUI] 用
  PluginDetails? _currentDetails;

  /// 附加构建上下文
  @override
  void attachBuildContext(BuildContext context) {
    return contextAttacher(context);
  }

  /// 获取应用名称
  @override
  Future<String> getAppName() async {
    // 获取包信息
    PackageInfo info = await PackageInfo.fromPlatform();
    // 获取应用名称
    return info.appName.isNotEmpty ? info.appName : "unknown";
  }

  /// 获取应用版本
  @override
  Future<String> getAppVersion() async {
    // 获取包信息
    PackageInfo info = await PackageInfo.fromPlatform();
    // 获取应用版本
    String name = info.version.isNotEmpty ? info.version : "unknown";
    String code = info.buildNumber.isNotEmpty ? info.buildNumber : "unknown";
    return "$name\t($code)";
  }

  /// 统计普通插件数量
  @override
  String pluginCount() {
    var count = 0;
    for (var element in pluginDetailsList) {
      if (element.type == PluginType.flutter) {
        count++;
      }
    }
    return count.toString();
  }

  /// 获取所有普通插件名称的集合
  @override
  String pluginNames() {
    final buffer = StringBuffer();
    for (var element in pluginDetailsList) {
      if (element.type == PluginType.flutter) {
        buffer.write('${element.title}\n');
      }
    }
    return buffer.toString();
  }

  /// 打开PubDev
  @override
  void launchPubDev() async {
    await launchUrl(
      Uri.parse(pubDevUrl),
    );
  }

  /// 获取插件列表
  @override
  List<PluginDetails> get getPluginDetailsList {
    return pluginDetailsList;
  }

  /// 获取插件图标
  @override
  Widget getPluginIcon(
    BuildContext context,
    PluginDetails details,
  ) {
    switch (details.type) {
      case PluginType.base:
        return Icon(
          Icons.compare_arrows,
          size: Theme.of(context).iconTheme.size,
          color: Colors.pinkAccent,
        );
      case PluginType.runtime:
        return Icon(
          Icons.bubble_chart,
          size: Theme.of(context).iconTheme.size,
          color: Colors.pinkAccent,
        );
      case PluginType.embedder:
        return Icon(
          Icons.keyboard_double_arrow_down,
          size: Theme.of(context).iconTheme.size,
          color: Colors.pinkAccent,
        );
      case PluginType.engine:
        return Icon(
          Icons.miscellaneous_services,
          size: Theme.of(context).iconTheme.size,
          color: Colors.blueAccent,
        );
      case PluginType.platform:
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            return Icon(
              Icons.android,
              size: Theme.of(context).iconTheme.size,
              color: Colors.green,
            );
          case TargetPlatform.fuchsia:
            return Icon(
              Icons.all_inclusive,
              size: Theme.of(context).iconTheme.size,
              color: Colors.pinkAccent,
            );
          case TargetPlatform.iOS:
            return Icon(
              Icons.apple,
              size: Theme.of(context).iconTheme.size,
              color: Colors.grey,
            );
          case TargetPlatform.linux:
            return Icon(
              Icons.desktop_windows,
              size: Theme.of(context).iconTheme.size,
              color: Colors.black,
            );
          case TargetPlatform.macOS:
            return Icon(
              Icons.apple,
              size: Theme.of(context).iconTheme.size,
              color: Colors.grey,
            );
          case TargetPlatform.windows:
            return Icon(
              Icons.window,
              size: Theme.of(context).iconTheme.size,
              color: Colors.blue,
            );
        }
      case PluginType.kernel:
        return Icon(
          Icons.memory,
          size: Theme.of(context).iconTheme.size,
          color: Colors.blueGrey,
        );
      case PluginType.flutter:
        return Icon(
          Icons.extension,
          size: Theme.of(context).iconTheme.size,
          color: Colors.lightGreen,
        );
      case PluginType.unknown:
        return Icon(
          Icons.error,
          size: Theme.of(context).iconTheme.size,
          color: Theme.of(context).colorScheme.error,
        );
    }
  }

  /// 获取插件类型
  @override
  String getPluginType(
    BuildContext context,
    PluginDetails details,
  ) {
    switch (details.type) {
      // 框架运行时
      case PluginType.runtime:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeRuntime;
      // 绑定通信层
      case PluginType.base:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeBase;
      // 平台嵌入层
      case PluginType.embedder:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeEmbedder;
      // 平台插件
      case PluginType.engine:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeEngine;
      // 平台插件
      case PluginType.platform:
        return AppLocalizations.of(
          context,
        ).managerPluginTypePlatform;
      // 内核模块
      case PluginType.kernel:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeKernel;
      // 普通插件
      case PluginType.flutter:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeFlutter;
      // 未知类型插件
      case PluginType.unknown:
        return AppLocalizations.of(
          context,
        ).managerPluginTypeUnknown;
    }
  }

  /// 获取插件的提示
  @override
  String getPluginTooltip(
    BuildContext context,
    PluginDetails details,
  ) {
    return _isAllowPush(details)
        ? runtimeChecker(details)
            ? AppLocalizations.of(
                context,
              ).managerPluginTooltipAbout
            : AppLocalizations.of(
                context,
              ).managerPluginTooltipOpen
        : AppLocalizations.of(
            context,
          ).managerPluginTooltipNoUI;
  }

  /// 打开卡片
  @override
  void clickPlugin(
    BuildContext context,
    PluginDetails details,
    VoidCallback launchPlugin,
    VoidCallback launchAbout,
    VoidCallback showTip,
  ) {
    if (!runtimeChecker(details)) {
      if (_isAllowPush(details)) {
        // 非运行时打开插件页面
        _currentDetails = details;
        launchPlugin();
      } else {
        // 插件无界面时打开提示
        showTip();
      }
    } else {
      // 运行时打开关于对话框
      launchAbout();
    }
  }

  /// 插件是否可以打开
  bool _isAllowPush(PluginDetails details) {
    return (details.type == PluginType.runtime ||
            details.type == PluginType.flutter) &&
        pluginGetter(details) != null;
  }

  @override
  void maximizeWindow() async {
    if (PlatformUtil.kIsDesktop) {
      return !await windowManager.isMaximized()
          ? await windowManager.maximize()
          : await windowManager.unmaximize();
    }
  }

  @override
  void startDragging() async {
    if (PlatformUtil.kIsDesktop) {
      return await windowManager.startDragging();
    }
  }

  @override
  void closeWindow() async {
    if (PlatformUtil.kIsDesktop) {
      return windowManager.close();
    }
  }

  @override
  void minimizeWindow() async {
    if (PlatformUtil.kIsDesktop) {
      return await windowManager.minimize();
    }
  }

  @override
  void exitApp() async {
    return PlatformUtil.kIsDesktop
        ? await windowManager.destroy()
        : await SystemNavigator.pop();
  }

  @override
  PluginDetails get getCurrentDetails {
    assert(() {
      if (_currentDetails == null) {
        throw Exception('currentDetails is null.');
      }
      return true;
    }());
    return _currentDetails!;
  }

  @override
  PluginWidgetGetter get getPluginWidget => pluginWidgetGetter;

  @override
  Widget get getRootWidget => rootWidget;

  /// 随机抽取一句心灵鸡汤
  @override
  String get getPoem => _list[Random().nextInt(_list.length)];
}
