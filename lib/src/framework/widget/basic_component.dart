part of '../framework.dart';

abstract base class UiBasicComponent extends Widget {
  const UiBasicComponent({super.key});

  @protected
  @factory
  @override
  UiBasicElement createElement();
}
