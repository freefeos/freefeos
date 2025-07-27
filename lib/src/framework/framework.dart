/// 系统框架层
library;

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../common/common.dart';

/// Context 上下文
part 'context/context_impl.dart';
part 'context/context_interface.dart';
part 'context/context_state_proxy.dart';
part 'context/context_widget_mixin.dart';
part 'context/context_wrapper.dart';
part 'context/context.dart';
part 'context/wrapper_construct.dart';

/// Layout 布局
part 'layout/layout.dart';
part 'layout/layout_element.dart';
part 'layout/layout_frame.dart';

/// Logcat 日志
part 'logcat/log.dart';
part 'logcat/parser_interface.dart';
part 'logcat/ansi_parser.dart';

part 'registry/registry.dart';

/// Resources 资源
part 'resources/resources.dart';

/// Service 服务
part 'service/binder_interface.dart';
part 'service/binder.dart';
part 'service/service_connection.dart';
part 'service/service.dart';

/// Want 意图
part 'want/want.dart';

/// Widget 组件
part 'widget/context_basic_wrapper.dart';
part 'widget/context_state_wrapper.dart';
part 'widget/context_stateful_wrapper.dart';
part 'widget/context_stateless_wrapper.dart';
