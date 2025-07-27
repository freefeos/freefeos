part of '../framework.dart';

abstract base class ContextThemeWrapper extends StatefulWidget
    with ContextWrapper {
  const ContextThemeWrapper({super.key});

  @protected
  @factory
  @override
  ContextStateWrapper createState();
}
