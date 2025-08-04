part of '../common.dart';

/// Flutter兼容层接口
class FreeFEOSCompat extends PlatformInterface {
  FreeFEOSCompat() : super(token: _token);

  /// 接口标志
  static final Object _token = Object();

  /// 接口实例
  static FreeFEOSCompat _instance = FreeFEOSCompat();

  /// 获取接口实例
  static FreeFEOSCompat get instance => _instance;

  /// 设置接口实例
  static set instance(FreeFEOSCompat instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 初始化微信接口
  Future<void> initDonutApi() {
    throw UnimplementedError('异常: 未实现initDonutApi()接口!');
  }

  /// 运行Donut应用
  Future<void> runDonutApp(Widget app) {
    throw UnimplementedError('异常: 未实现runDonutApp()接口!');
  }

  /// 初始化App代理
  Future<void> initDelegate() {
    throw UnimplementedError('异常: 未实现initDelegate()接口!');
  }

  /// 添加颜色模式监听
  void addThemeModeChangeListener(VoidCallback callback) {
    throw UnimplementedError('异常: 未实现addThemeModeChangeListener()接口!');
  }

  /// 写入剪贴板数据
  void setClipboardData(String text, VoidCallback showTips) {
    throw UnimplementedError('异常: 未实现setClipboardData()接口!');
  }

  /// 小程序设置的按钮
  Widget openSetting({required Widget child}) {
    throw UnimplementedError('异常: 未实现settingButton()接口!');
  }

  /// 客服按钮
  Widget openCustomer({required Widget child}) {
    throw UnimplementedError('异常: 未实现customerButton()接口!');
  }

  /// 设置分享信息
  void setAppShareInfo({
    required BuildContext context,
    required String title,
    required Map<dynamic, dynamic> query,
  }) {
    throw UnimplementedError('异常: 未实现setAppShareInfo()接口!');
  }

  /// 打开EKit的按钮
  Widget openEKit({required Widget child}) {
    throw UnimplementedError('异常: 未实现eKitButton()接口!');
  }

  /// 返回微信的按钮
  Widget openWeChat({required Widget child}) {
    throw UnimplementedError('异常: 未实现weChatButton()接口!');
  }

  /// 获取导航观察器
  NavigatorObserver get getNavigatorObserver {
    throw UnimplementedError('异常: 未实现getNavigatorObserver接口!');
  }

  /// 判断是否深色模式
  ThemeMode get getThemeMode {
    throw UnimplementedError('异常: 未实现getThemeMode接口!');
  }

  /// 根据胶囊按钮位置精确计算顶部应用栏高度
  AppBarTheme get getAppBarTheme {
    throw UnimplementedError('异常: 未实现getAppBarTheme接口!');
  }

  /// 检查运行环境, 真为微信小程序
  bool get checkEnv {
    throw UnimplementedError('异常: 未实现checkEnv接口!');
  }

  /// 获取小程序AppID
  String get getAppId {
    throw UnimplementedError('异常: 未实现getAppId接口!');
  }

  /// 获取环境版本
  String get getVersionStage {
    throw UnimplementedError('异常: 未实现getEnvVersion接口!');
  }

  /// 获取版本
  String get getVersionName {
    throw UnimplementedError('异常: 未实现getVersion接口!');
  }

  /// 获取微信客户端版本号
  String get getHostAppVersion {
    throw UnimplementedError('异常: 未实现getHostAppVersion接口!');
  }

  /// 获取微信基础库版本号
  String get getBaseSdkVersion {
    throw UnimplementedError('异常: 未实现getBaseSdkVersion接口!');
  }
}
