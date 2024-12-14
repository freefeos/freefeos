import '../base/base.dart';
import '../common/interface/interface.dart';
import 'runtime.dart';

/// 运行时混入
base mixin RuntimeMixin implements ISystemBase {
  /// 获取运行时实例
  @override
  FreeFEOSSystem call() => SystemRuntime();
}
