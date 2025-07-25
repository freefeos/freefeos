/// 标准库
library;

import 'package:flutter/material.dart';

import '../common/common.dart';
import '../engine/engine.dart';
import '../framework/framework.dart';
import '../kernel/kernel.dart';

/// 系统能力ViewModel
part 'osvm/osvm_interface.dart';
part 'osvm/osvm_impl.dart';

/// SDK
part 'sdk/sdk_extension.dart';
part 'sdk/sdk_impl.dart';
part 'sdk/sdk_interface.dart';

/// 系统能力标准库
part 'std/std_impl.dart';
