part of '../framework.dart';

abstract base class ContextStatefulWrapper extends StatefulWidget
    with ContextWidgetMixin {
  const ContextStatefulWrapper({super.key});

  @protected
  @factory
  @override
  ContextStateWrapper createState();
}

abstract base class ContextStateWrapper<T extends ContextStatefulWrapper>
    extends State<T>
    with ContextStateProxy<T> {
  ContextStateWrapper();
}
