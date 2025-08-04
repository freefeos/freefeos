part of '../framework.dart';

abstract base class UiApp extends UiStatelessComponent {
  const UiApp({super.key, required this.viewModel});

  final ViewModel viewModel;
}
