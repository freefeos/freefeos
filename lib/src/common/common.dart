/// Common 通用库
library;

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:provider/provider.dart';

import '../loader/loader.dart';
import '../framework/framework.dart';
import '../runtime/runtime.dart';
import '../manager/manager.dart';
import '../standard/standard.dart';

/// Envents 事件
part 'event/event_buffer.dart';
part 'event/event_output.dart';
part 'event/event_rendered.dart';

/// Interface 接口
part 'interface/loader_interface.dart';
part 'interface/compat_interface.dart';
part 'interface/system_interface.dart';

/// Library 库
part 'library/app.dart';
part 'library/component.dart';
part 'library/option.dart';
part 'library/page.dart';
part 'library/provider.dart';
part 'library/screen.dart';

/// Manifest 清单
part 'manifest/manifest_ecosedkit.dart';
part 'manifest/manifest_freefeos.dart';
part 'manifest/manifest_interface.dart';
part 'manifest/manifest.dart';

/// Model 模型
part 'model/module_details.dart';

/// Types 类型
part 'types/types.dart';

/// Utils 工具
part 'utils/utils.dart';

/// Values 值
part 'values/channel.dart';
part 'values/colors.dart';
part 'values/drawable.dart';
part 'values/method.dart';
part 'values/placeholder.dart';
part 'values/strings.dart';
part 'values/values.dart';
