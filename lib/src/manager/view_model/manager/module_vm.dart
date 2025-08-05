part of '../../manager.dart';

/// 模块VM
final class ModuleViewModel with ViewModel implements IModuleViewModel {
  ModuleViewModel();

  /// 模块列表
  final List<ModuleDetails> _moduleList = [];
  final List<ModuleDetails> _componentList = [];

  @override
  void dispose() {
    super.dispose();
    _moduleList.clear();
    _componentList.clear();
  }

  @override
  void init(OSAbility ability) {
    List<ModuleDetails> moduleTemp = [];
    List<ModuleDetails> componentTemp = [];
    for (int i = 0; i < ability.getDetailsList.length; i++) {
      if (ability.getDetailsList[i].type != ModuleType.component) {
        moduleTemp.add(ability.getDetailsList[i]);
      } else {
        componentTemp.add(ability.getDetailsList[i]);
      }
    }
    if (_moduleList.length < moduleTemp.length) {
      _moduleList.addAll(moduleTemp);
    }
    if (_componentList.length < componentTemp.length) {
      _componentList.addAll(componentTemp);
    }
  }

  @override
  List<Widget> moduleList({
    required BuildContext context,
    required DetailDialogLauncher showDetail,
    required WidgetBuilder dividerBuilder,
    required ModuleItemBuilder itemBuilder,
  }) {
    List<Widget> temp = [];
    if (_moduleList.isNotEmpty) {
      if (temp.length < _moduleList.length) {
        for (int i = 0; i < _moduleList.length; i++) {
          temp.add(
            itemBuilder(
              context,
              () => showDetail(
                context,
                _moduleList[i].title,
                _moduleList[i].id,
                _getIcon(_moduleList, i),
                _moduleList[i].description,
              ),
              _moduleList[i].title,
              _getIcon(_moduleList, i),
              _moduleList.isNotEmpty && i == 0,
              _moduleList.isNotEmpty && _moduleList.length - 1 == i,
            ),
          );
          if (i != _moduleList.length - 1) {
            temp.add(dividerBuilder(context));
          }
        }
      }
    }
    return temp;
  }

  @override
  List<Widget> componentList({
    required BuildContext context,
    required DetailDialogLauncher showDetail,
    required WidgetBuilder dividerBuilder,
    required ModuleItemBuilder itemBuilder,
  }) {
    List<Widget> temp = [];
    if (_componentList.isNotEmpty) {
      if (temp.length < _componentList.length) {
        for (int i = 0; i < _componentList.length; i++) {
          temp.add(
            itemBuilder(
              context,
              () => showDetail(
                context,
                _componentList[i].title,
                _componentList[i].id,
                _getIcon(_componentList, i),
                _componentList[i].description,
              ),
              _componentList[i].title,
              _getIcon(_componentList, i),
              _componentList.isNotEmpty && i == 0,
              _moduleList.isNotEmpty && _componentList.length - 1 == i,
            ),
          );
          if (i != _componentList.length - 1) {
            temp.add(dividerBuilder(context));
          }
        }
      }
    }
    return temp;
  }

  /// 获取图标
  IconData _getIcon(List<ModuleDetails> list, int i) {
    switch (list[i].type) {
      case ModuleType.runtime:
        return Icons.bubble_chart;
      case ModuleType.engine:
        return Icons.miscellaneous_services;
      case ModuleType.component:
        return Icons.extension;
      case ModuleType.unknown:
        return Icons.error;
    }
  }
}
