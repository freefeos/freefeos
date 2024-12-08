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

  /// 用于FutureBuilder等组件.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get unknown;

  /// 用于FutureBuilder等组件.
  ///
  /// In zh, this message translates to:
  /// **'等待'**
  String get waiting;

  /// 用于FutureBuilder等组件.
  ///
  /// In zh, this message translates to:
  /// **'错误'**
  String get error;

  /// 用于FutureBuilder等组件.
  ///
  /// In zh, this message translates to:
  /// **'空'**
  String get sNull;

  /// No description provided for @packageName.
  ///
  /// In zh, this message translates to:
  /// **'freefeos'**
  String get packageName;

  /// No description provided for @bannerTitle.
  ///
  /// In zh, this message translates to:
  /// **'FREEFEOS'**
  String get bannerTitle;

  /// No description provided for @bottomSheetTooltip.
  ///
  /// In zh, this message translates to:
  /// **'菜单'**
  String get bottomSheetTooltip;

  /// No description provided for @bottomSheetManager.
  ///
  /// In zh, this message translates to:
  /// **'管理器'**
  String get bottomSheetManager;

  /// No description provided for @bottomSheetManagerTooltip.
  ///
  /// In zh, this message translates to:
  /// **'打开管理器'**
  String get bottomSheetManagerTooltip;

  /// No description provided for @bottomSheetAboutTooltip.
  ///
  /// In zh, this message translates to:
  /// **'打开关于对话框'**
  String get bottomSheetAboutTooltip;

  /// No description provided for @bottomSheetClose.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get bottomSheetClose;

  /// No description provided for @bottomSheetCloseTooltip.
  ///
  /// In zh, this message translates to:
  /// **'关闭对话框'**
  String get bottomSheetCloseTooltip;

  /// No description provided for @bottomSheetExit.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get bottomSheetExit;

  /// No description provided for @bottomSheetExitToolTip.
  ///
  /// In zh, this message translates to:
  /// **'退出应用'**
  String get bottomSheetExitToolTip;

  /// No description provided for @aboutDialogLegalese.
  ///
  /// In zh, this message translates to:
  /// **'使用 FreeFEOS 开发'**
  String get aboutDialogLegalese;

  /// No description provided for @closeDialogTitle.
  ///
  /// In zh, this message translates to:
  /// **'退出应用'**
  String get closeDialogTitle;

  /// No description provided for @closeDialogMessage.
  ///
  /// In zh, this message translates to:
  /// **'是否退出应用?\n此功能在iOS下不可用,请直接退出.'**
  String get closeDialogMessage;

  /// No description provided for @closeDialogCancelButton.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get closeDialogCancelButton;

  /// No description provided for @closeDialogExitButton.
  ///
  /// In zh, this message translates to:
  /// **'退出'**
  String get closeDialogExitButton;

  /// No description provided for @managerTitle.
  ///
  /// In zh, this message translates to:
  /// **'系统管理器'**
  String get managerTitle;

  /// No description provided for @managerDestinationHome.
  ///
  /// In zh, this message translates to:
  /// **'主页'**
  String get managerDestinationHome;

  /// No description provided for @managerDestinationLog.
  ///
  /// In zh, this message translates to:
  /// **'日志'**
  String get managerDestinationLog;

  /// No description provided for @managerDestinationPlugin.
  ///
  /// In zh, this message translates to:
  /// **'插件'**
  String get managerDestinationPlugin;

  /// No description provided for @managerDestinationSetting.
  ///
  /// In zh, this message translates to:
  /// **'设置'**
  String get managerDestinationSetting;

  /// No description provided for @managerHomeInfoAppName.
  ///
  /// In zh, this message translates to:
  /// **'应用名称'**
  String get managerHomeInfoAppName;

  /// No description provided for @managerHomeInfoAppVersion.
  ///
  /// In zh, this message translates to:
  /// **'应用版本'**
  String get managerHomeInfoAppVersion;

  /// No description provided for @managerHomeInfoPlatform.
  ///
  /// In zh, this message translates to:
  /// **'当前平台'**
  String get managerHomeInfoPlatform;

  /// No description provided for @managerHomeInfoPluginCount.
  ///
  /// In zh, this message translates to:
  /// **'插件数量'**
  String get managerHomeInfoPluginCount;

  /// No description provided for @managerHomeInfoAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get managerHomeInfoAbout;

  /// No description provided for @managerHomeLearnTitle.
  ///
  /// In zh, this message translates to:
  /// **'了解 FreeFEOS'**
  String get managerHomeLearnTitle;

  /// No description provided for @managerHomeLearnDescription.
  ///
  /// In zh, this message translates to:
  /// **'了解如何使用 FreeFEOS 进行开发。'**
  String get managerHomeLearnDescription;

  /// No description provided for @managerHomeLearnTooltip.
  ///
  /// In zh, this message translates to:
  /// **'了解更多'**
  String get managerHomeLearnTooltip;

  /// No description provided for @managerLogCopyTips.
  ///
  /// In zh, this message translates to:
  /// **'已复制到剪贴板!'**
  String get managerLogCopyTips;

  /// No description provided for @managerPluginChannel.
  ///
  /// In zh, this message translates to:
  /// **'通道'**
  String get managerPluginChannel;

  /// No description provided for @managerPluginAuthor.
  ///
  /// In zh, this message translates to:
  /// **'作者'**
  String get managerPluginAuthor;

  /// No description provided for @managerPluginTypeRuntime.
  ///
  /// In zh, this message translates to:
  /// **'系统运行时'**
  String get managerPluginTypeRuntime;

  /// No description provided for @managerPluginTypeBase.
  ///
  /// In zh, this message translates to:
  /// **'绑定通信层'**
  String get managerPluginTypeBase;

  /// No description provided for @managerPluginTypeEmbedder.
  ///
  /// In zh, this message translates to:
  /// **'平台嵌入层'**
  String get managerPluginTypeEmbedder;

  /// No description provided for @managerPluginTypeEngine.
  ///
  /// In zh, this message translates to:
  /// **'引擎插件'**
  String get managerPluginTypeEngine;

  /// No description provided for @managerPluginTypePlatform.
  ///
  /// In zh, this message translates to:
  /// **'平台插件'**
  String get managerPluginTypePlatform;

  /// No description provided for @managerPluginTypeKernel.
  ///
  /// In zh, this message translates to:
  /// **'内核模块'**
  String get managerPluginTypeKernel;

  /// No description provided for @managerPluginTypeFlutter.
  ///
  /// In zh, this message translates to:
  /// **'普通插件'**
  String get managerPluginTypeFlutter;

  /// No description provided for @managerPluginTypeUnknown.
  ///
  /// In zh, this message translates to:
  /// **'未知类型插件'**
  String get managerPluginTypeUnknown;

  /// No description provided for @managerPluginActionOpen.
  ///
  /// In zh, this message translates to:
  /// **'打开'**
  String get managerPluginActionOpen;

  /// No description provided for @managerPluginActionAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get managerPluginActionAbout;

  /// No description provided for @managerPluginActionNoUI.
  ///
  /// In zh, this message translates to:
  /// **'无界面'**
  String get managerPluginActionNoUI;

  /// No description provided for @managerPluginTooltipOpen.
  ///
  /// In zh, this message translates to:
  /// **'打开插件的界面'**
  String get managerPluginTooltipOpen;

  /// No description provided for @managerPluginTooltipAbout.
  ///
  /// In zh, this message translates to:
  /// **'关于本框架'**
  String get managerPluginTooltipAbout;

  /// No description provided for @managerPluginTooltipNoUI.
  ///
  /// In zh, this message translates to:
  /// **'此插件没有界面'**
  String get managerPluginTooltipNoUI;
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
      'that was used.');
}
