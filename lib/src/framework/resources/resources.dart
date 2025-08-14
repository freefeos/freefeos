part of '../framework.dart';

final class Resources {
  const Resources();

  Layout getLayout({required WidgetBuilder builder}) {
    return Layout(layout: Builder(builder: builder));
  }

  T getValues<T>({required T value}) {
    return value;
  }

  String getDrawable({required DrawableRes res}) {
    return utf8.decode(base64Decode(res));
  }
}
