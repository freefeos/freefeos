part of '../framework.dart';

final class Resources {
  const Resources();

  Layout getLayout({required WidgetBuilder builder}) {
    return Layout(layout: Builder(builder: builder));
  }

  T getValues<T>({required T value}) {
    return value;
  }
}
