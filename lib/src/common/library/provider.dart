part of '../common.dart';

/// 系统能力调用的ViewModel的专用Provider
final class OSAbilityProvider extends ViewModelProvider<OSAbility> {
  OSAbilityProvider({super.key, required ViewModel viewModel})
    : super(create: (context) => _create(context, viewModel));

  static OSAbility _create(BuildContext context, ViewModel viewModel) {
    assert(() {
      if (viewModel is! OSAbility) {
        throw FlutterError('异常: ViewModel类型错误!');
      }
      return true;
    }());
    return viewModel as OSAbility;
  }
}
