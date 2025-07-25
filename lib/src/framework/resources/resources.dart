part of '../framework.dart';

final class Resources {
  const Resources();

  Layout getLayout({required WidgetBuilder builder}) {
    return Layout(layout: Builder(builder: builder));
  }

  dynamic getValues({required dynamic value}) {
    return value;
  }
}
