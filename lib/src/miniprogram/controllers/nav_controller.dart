part of '../miniprogram.dart';

final class NavController {
  NavController();

  final List<UiScreen> _screenList = [];

  final ValueNotifier<int> destinationNotifier = ValueNotifier(0);

  /// 销毁导航控制器
  void dispose() {
    destinationNotifier.dispose();
    _screenList.clear();
  }

  /// 获取页面列表
  List<UiScreen> get getDestinationList => _screenList;

  /// 获取当前页面标题
  String get getCurrentTitle {
    return _screenList[destinationNotifier.value].getTitle;
  }

  /// 获取当前页面索引
  int get getCurrentIndex {
    return _screenList[destinationNotifier.value].getIndex;
  }

  /// 注册页面
  NavController register({
    required BuildContext context,
    required int defaultIndex,
    required List<UiScreenBuilder> builders,
  }) {
    if (builders.isNotEmpty) {
      if (_screenList.length < builders.length) {
        for (var i = 0; i < builders.length; i++) {
          final UiScreen current = builders[i](context);
          if (_screenList.isEmpty ||
              _screenList.any((element) {
                return element.getIndex != current.getIndex;
              })) {
            _screenList.insert(current.getIndex, current);
          }
        }
      }
    } else {
      throw FlutterError('builders is empty');
    }
    if (defaultIndex < _screenList.length) {
      destinationNotifier.value = _screenList[defaultIndex].getIndex;
    }
    return this;
  }

  /// 切换到首页
  void animateToFirst() {
    if (_screenList[destinationNotifier.value].getIndex !=
        _screenList.first.getIndex) {
      // 切换首页
      destinationNotifier.value = _screenList.first.getIndex;
    }
  }
}
