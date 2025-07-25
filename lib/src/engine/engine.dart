/// 系统引擎层
library;

import 'package:flutter/material.dart';

import '../base/base.dart';
import '../common/common.dart';
import '../embedder/embedder.dart';
import '../framework/framework.dart';
import '../kernel/kernel.dart';
import '../runtime/runtime.dart';
import '../standard/standard.dart';

/// Bridge
part 'bridge/bridge_mixin.dart';
part 'bridge/bridge.dart';
part 'bridge/engine_mixin.dart';

/// Component
part 'component/binding.dart';
part 'component/channel.dart';
part 'component/component_mixin.dart';
part 'component/component.dart';

/// Impl
part 'impl/engine_impl.dart';

/// Import
part 'import/call_import.dart';
part 'import/result_import.dart';

/// Interface
part 'interface/bridge_interface.dart';
part 'interface/bridge_mixin_interface.dart';
part 'interface/engine_interface.dart';
part 'interface/method_call.dart';
part 'interface/proxy.dart';
part 'interface/result.dart';
