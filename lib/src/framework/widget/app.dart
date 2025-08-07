part of '../framework.dart';

abstract base class UiApp extends UiStatelessComponent {
  const UiApp({super.key, required this.viewModel});

  final ViewModel viewModel;

  ViewModel get getViewModel => viewModel;

  /// 页面
  Map<RouteName, UiPageBuilder> get buildPages;

  /// 样式
  ThemeData buildStyle(BuildContext context);

  /// ViewModel
  List<ViewModelProvider> get buildViewModel;
}
