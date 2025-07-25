part of '../common.dart';

abstract base class UiApp extends UiComponent {
  const UiApp({super.key, required this.viewModel});

  final ViewModel viewModel;
}
