// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get selfAppName => 'FreeFEOS';

  @override
  String get componentHeaderTitleFreeFEOS => 'FreeFEOS';

  @override
  String get componentHeaderTitleEcosedKit => 'EcosedKit';

  @override
  String get componentHeaderTitleWeChat => 'WeChat';

  @override
  String get componentHeaderTitleClock => 'Clock';

  @override
  String get componentHeaderTitleCalculator => 'Calculator';

  @override
  String get componentFooterMadeMPFlutter => '基于 MPFlutter 构建';

  @override
  String get componentFooterMadeUniAppX => '基于 UniAppX 构建';

  @override
  String componentFooterCopyright(String date) {
    return 'Copyright © $date wyq0918dev. All Rights Reserved.';
  }

  @override
  String get indexNavBarTitle => 'feOS';

  @override
  String get indexTabBarHomeTitle => '首页';

  @override
  String get indexTabBarHomeTooltip => '首页';

  @override
  String get indexTabBarLogcatTitle => '日志';

  @override
  String get indexTabBarLogcatTooltip => '日志';

  @override
  String get indexTabBarModuleTitle => '模块';

  @override
  String get indexTabBarModuleTooltip => '模块';

  @override
  String get indexTabBarSettingTitle => '设置';

  @override
  String get indexTabBarSettingTooltip => '设置';

  @override
  String get indexHomeStatuesCardTooltip => '小程序状态';

  @override
  String get indexHomeStatuesCardTitle => 'FreeFEOS MiniApp';

  @override
  String indexHomeStatuesCardAppId(String appId) {
    return 'AppID: $appId';
  }

  @override
  String indexHomeStatuesCardAppVersion(String appVersion) {
    return '版本号: $appVersion';
  }

  @override
  String indexHomeStatuesCardEnvVersion(String envVersion) {
    return '环境版本: $envVersion';
  }

  @override
  String get indexHomeInfoCardHostAppTooltip => '客户端版本';

  @override
  String get indexHomeInfoCardHostAppTitle => '客户端版本';

  @override
  String get indexHomeInfoCardBaseSdkTooltip => '基础库版本';

  @override
  String get indexHomeInfoCardBaseSdkTitle => '基础库版本';

  @override
  String get indexHomeInfoCardVersionTooltip => '小程序版本';

  @override
  String get indexHomeInfoCardVersionTitle => '小程序版本';

  @override
  String get indexHomeAppsCardTitle => 'feOS 应用';

  @override
  String get indexHomeAppsCardBanner => '工具箱';

  @override
  String get indexHomeAppsCardEKitAppName => 'EKit';

  @override
  String get indexHomeAppsCardEKitAppTooltip => 'EKit';

  @override
  String get indexHomeAppsCardWeChatAppName => '微信';

  @override
  String get indexHomeAppsCardWeChatAppTooltip => '微信';

  @override
  String get indexHomeAppsCardClockAppName => '时钟';

  @override
  String get indexHomeAppsCardClockAppTooltip => '时钟';

  @override
  String get indexHomeAppsCardCalculatorAppName => '计算器';

  @override
  String get indexHomeAppsCardCalculatorAppTooltip => '计算器';

  @override
  String get indexLogcatItemCopyTips => '已复制到剪贴板';

  @override
  String get indexLogcatSnackBarAction => '确定';

  @override
  String get indexModuleTypeTextBase => '基础层';

  @override
  String get indexModuleTypeTextRuntime => '运行时';

  @override
  String get indexModuleTypeTextEngine => '引擎层';

  @override
  String get indexModuleTypeTextComponent => '系统组件';

  @override
  String get indexModuleTypeTextUnknown => '未知';

  @override
  String get appsWeChatDialogCancelTitle => '取消';

  @override
  String get appsWeChatDialogCancelTooltip => '取消';

  @override
  String get appsWeChatDialogExitTitle => '退出';

  @override
  String get appsWeChatDialogExitTooltip => '退出';
}
