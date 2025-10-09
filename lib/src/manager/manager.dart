library;

import 'dart:async';
import 'dart:collection';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../common/common.dart';
import '../framework/framework.dart';
import '../runtime/runtime.dart';
import 'intl/app_localizations.dart';

/// Components 组件
part 'components/capsule_button.dart';
part 'components/nav_bar.dart';
part 'components/nav_host.dart';
part 'components/nav_title.dart';
part 'components/root_theme.dart';
part 'components/screen_adapter.dart';

/// Controllers 控制器
part 'controllers/nav_controller.dart';

/// Pages 页面
part 'pages/index.dart';
part 'pages/manager.dart';
part 'pages/licenses.dart';
part 'pages/about.dart';
part 'pages/details.dart';
part 'pages/settings.dart';

part 'screen/home.dart';
part 'screen/logcat.dart';
part 'screen/module.dart';
part 'screen/setting.dart';

/// Utils 工具
part 'utils/utils.dart';

/// ViewModel 视图模型
part 'view_model/details/details_vm.dart';
part 'view_model/index/index_vm.dart';
part 'view_model/manager/home_vm.dart';
part 'view_model/manager/logcat_vm.dart';
part 'view_model/manager/module_vm.dart';

/// App
part 'app.dart';
