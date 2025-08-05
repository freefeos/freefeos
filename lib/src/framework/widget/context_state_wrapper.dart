part of '../framework.dart';

abstract base class ContextStateWrapper<T extends ContextStatefulWrapper>
    extends State<T>
    with ContextStateProxy<T> {
  ContextStateWrapper();
}
