part of '../framework.dart';

abstract base class ContextStatefulWrapper extends UiStatefulComponent
    with ContextWidgetMixin {
  const ContextStatefulWrapper({super.key});

  @protected
  @factory
  @override
  ContextStateWrapper createState();
}
