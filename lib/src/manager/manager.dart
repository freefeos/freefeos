/// 小程序用户界面层
library;

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/common.dart';
import '../framework/framework.dart';
import '../runtime/runtime.dart';
import 'intl/app_localizations.dart';

/// Components 组件
part 'components/calculator_button.dart';
part 'components/capsule_button.dart';
part 'components/clock_view.dart';
part 'components/footer.dart';
part 'components/header.dart';
part 'components/nav_bar.dart';
part 'components/nav_drawer.dart';
part 'components/nav_host.dart';
part 'components/screen_adapter.dart';
part 'components/shell_builder.dart';
part 'components/text_clock.dart';
part 'components/nav_title.dart';

/// Controllers 控制器
part 'controllers/nav_controller.dart';

/// Pages 页面
part 'pages/apps/apps.dart';
part 'pages/apps/ecosed.dart';
part 'pages/apps/wechat.dart';
part 'pages/apps/clock.dart';
part 'pages/apps/calculator.dart';
part 'pages/index/index.dart';
part 'pages/manager/manager.dart';
part 'pages/manager/home.dart';
part 'pages/manager/logcat.dart';
part 'pages/manager/module.dart';
part 'pages/manager/setting.dart';

/// Utils 工具
part 'utils/utils.dart';

/// ViewModel 视图模型
part 'view_model/apps/calculator_interface.dart';
part 'view_model/apps/calculator_vm.dart';
part 'view_model/apps/operator_type.dart';

part 'view_model/index/home_interface.dart';
part 'view_model/index/home_vm.dart';

part 'view_model/index/logcat_interface.dart';
part 'view_model/index/logcat_vm.dart';

part 'view_model/index/module_interface.dart';
part 'view_model/index/module_vm.dart';

/// App
part 'app.dart';
