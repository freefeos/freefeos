part of '../framework.dart';

abstract base class ContextStatefulWrapper extends StatefulWidget
    with ContextWrapper {
  const ContextStatefulWrapper({super.key});

  @protected
  @factory
  @override
  ContextStateWrapper createState();
}
