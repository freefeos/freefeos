import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'intl/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('zh')];

  /// feOS 应用名称
  ///
  /// In zh, this message translates to:
  /// **'FreeFEOS'**
  String get selfAppName;

  /// FreeFEOS 应用名称
  ///
  /// In zh, this message translates to:
  /// **'FreeFEOS'**
  String get componentHeaderTitleFreeFEOS;

  /// EcosedKit 应用名称
  ///
  /// In zh, this message translates to:
  /// **'EcosedKit'**
  String get componentHeaderTitleEcosedKit;

  /// 微信应用名称
  ///
  /// In zh, this message translates to:
  /// **'WeChat'**
  String get componentHeaderTitleWeChat;

  /// 时钟应用名称
  ///
  /// In zh, this message translates to:
  /// **'Clock'**
  String get componentHeaderTitleClock;

  /// 计算器应用名称
  ///
  /// In zh, this message translates to:
  /// **'Calculator'**
  String get componentHeaderTitleCalculator;

  /// 构建信息
  ///
  /// In zh, this message translates to:
  /// **'基于 MPFlutter 构建'**
  String get componentFooterMadeMPFlutter;

  /// 构建信息
  ///
  /// In zh, this message translates to:
  /// **'基于 UniAppX 构建'**
  String get componentFooterMadeUniAppX;

  /// 版权信息
  ///
  /// In zh, this message translates to:
  /// **'Copyright © {date} wyq0918dev. All Rights Reserved.'**
  String componentFooterCopyright(String date);

  /// feOS 应用名称
  ///
  /// In zh, this message translates to:
  /// **'feOS'**
  String get indexNavBarTitle;

  /// 首页
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get indexTabBarHomeTitle;

  /// 首页页提示
  ///
  /// In zh, this message translates to:
  /// **'首页'**
  String get indexTabBarHomeTooltip;

  /// 日志
  ///
  /// In zh, this message translates to:
  /// **'日志'**
  String get indexTabBarLogcatTitle;

  /// 日志页提示
  ///
  /// In zh, this message translates to:
  /// **'日志'**
  String get indexTabBarLogcatTooltip;

  /// 模块TabBar标题
  ///
  /// In zh, this message translates to:
  /// **'模块'**
  String get indexTabBarModuleTitle;

  /// 模块页提示
  ///
  /// In zh, this message translates to:
  /// **'模块'**
  String get indexTabBarModuleTooltip;

  /// 设置TabBar标题
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get indexTabBarSettingTitle;

  /// 设置页提示
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get indexTabBarSettingTooltip;

  /// 小程序状态卡片的提示
  ///
  /// In zh, this message translates to:
  /// **'小程序状态'**
  String get indexHomeStatuesCardTooltip;

  /// 小程序状态卡片的标题
  ///
  /// In zh, this message translates to:
  /// **'FreeFEOS MiniApp'**
  String get indexHomeStatuesCardTitle;

  /// 小程序状态卡片的小程序AppID
  ///
  /// In zh, this message translates to:
  /// **'AppID: {appId}'**
  String indexHomeStatuesCardAppId(String appId);

  /// 小程序状态卡片的小程序版本
  ///
  /// In zh, this message translates to:
  /// **'版本号: {appVersion}'**
  String indexHomeStatuesCardAppVersion(String appVersion);

  /// 小程序状态卡片的环境版本
  ///
  /// In zh, this message translates to:
  /// **'环境版本: {envVersion}'**
  String indexHomeStatuesCardEnvVersion(String envVersion);

  /// 小程序信息卡片的客户端版本提示
  ///
  /// In zh, this message translates to:
  /// **'客户端版本'**
  String get indexHomeInfoCardHostAppTooltip;

  /// 小程序信息卡片的客户端版本
  ///
  /// In zh, this message translates to:
  /// **'客户端版本'**
  String get indexHomeInfoCardHostAppTitle;

  /// 小程序信息卡片的基础库版本提示
  ///
  /// In zh, this message translates to:
  /// **'基础库版本'**
  String get indexHomeInfoCardBaseSdkTooltip;

  /// 小程序信息卡片的基础库版本
  ///
  /// In zh, this message translates to:
  /// **'基础库版本'**
  String get indexHomeInfoCardBaseSdkTitle;

  /// 小程序信息卡片的小程序版本提示
  ///
  /// In zh, this message translates to:
  /// **'小程序版本'**
  String get indexHomeInfoCardVersionTooltip;

  /// 小程序信息卡片的小程序版本
  ///
  /// In zh, this message translates to:
  /// **'小程序版本'**
  String get indexHomeInfoCardVersionTitle;

  /// 小程序应用卡片的标题
  ///
  /// In zh, this message translates to:
  /// **'feOS 应用'**
  String get indexHomeAppsCardTitle;

  /// 小程序应用卡片的横幅
  ///
  /// In zh, this message translates to:
  /// **'工具箱'**
  String get indexHomeAppsCardBanner;

  /// 小程序应用卡片的EKit应用
  ///
  /// In zh, this message translates to:
  /// **'EKit'**
  String get indexHomeAppsCardEKitAppName;

  /// 小程序应用卡片的EKit应用提示
  ///
  /// In zh, this message translates to:
  /// **'EKit'**
  String get indexHomeAppsCardEKitAppTooltip;

  /// 小程序应用卡片的微信应用
  ///
  /// In zh, this message translates to:
  /// **'微信'**
  String get indexHomeAppsCardWeChatAppName;

  /// 小程序应用卡片的微信应用提示
  ///
  /// In zh, this message translates to:
  /// **'微信'**
  String get indexHomeAppsCardWeChatAppTooltip;

  /// 小程序应用卡片的时钟应用
  ///
  /// In zh, this message translates to:
  /// **'时钟'**
  String get indexHomeAppsCardClockAppName;

  /// 小程序应用卡片的时钟应用提示
  ///
  /// In zh, this message translates to:
  /// **'时钟'**
  String get indexHomeAppsCardClockAppTooltip;

  /// 小程序应用卡片的计算器应用
  ///
  /// In zh, this message translates to:
  /// **'计算器'**
  String get indexHomeAppsCardCalculatorAppName;

  /// 小程序应用卡片的计算器应用提示
  ///
  /// In zh, this message translates to:
  /// **'计算器'**
  String get indexHomeAppsCardCalculatorAppTooltip;

  /// 复制到剪贴板提示
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪贴板'**
  String get indexLogcatItemCopyTips;

  /// 确定按钮
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get indexLogcatSnackBarAction;

  /// 基础层模块标题
  ///
  /// In zh, this message translates to:
  /// **'基础层'**
  String get indexModuleTypeTextBase;

  /// 运行时模块标题
  ///
  /// In zh, this message translates to:
  /// **'运行时'**
  String get indexModuleTypeTextRuntime;

  /// 引擎模块标题
  ///
  /// In zh, this message translates to:
  /// **'引擎层'**
  String get indexModuleTypeTextEngine;

  /// 系统组件模块标题
  ///
  /// In zh, this message translates to:
  /// **'系统组件'**
  String get indexModuleTypeTextComponent;

  /// 未知类型模块
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get indexModuleTypeTextUnknown;

  /// 取消按钮
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get appsWeChatDialogCancelTitle;

  /// 取消按钮提示
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get appsWeChatDialogCancelTooltip;

  /// 退出按钮
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get appsWeChatDialogExitTitle;

  /// 退出按钮提示
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get appsWeChatDialogExitTooltip;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
