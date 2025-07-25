part of '../../miniprogram.dart';

/// 模块VM接口
abstract interface class IModuleViewModel {
  void init(OSAbility ability);

  List<Widget> moduleList({
    required BuildContext context,
    required DetailDialogLauncher showDetail,
    required WidgetBuilder dividerBuilder,
    required ModuleItemBuilder itemBuilder,
  });

  List<Widget> componentList({
    required BuildContext context,
    required DetailDialogLauncher showDetail,
    required WidgetBuilder dividerBuilder,
    required ModuleItemBuilder itemBuilder,
  });
}
