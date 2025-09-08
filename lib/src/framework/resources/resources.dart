part of '../framework.dart';

final class Resources {
  const Resources();

  Layout getLayout({required WidgetBuilder builder}) {
    return Layout(layout: Builder(builder: builder));
  }

  String getChannel({required StringRes channel}) {
    return channel;
  }

  String getDrawable({required DrawableRes res}) {
    return utf8.decode(base64Decode(res));
  }

  String getMethod({required MethodName method}) {
    return method;
  }

  ModuleData getPlaceholder({required ModuleData placeholder}) {
    return placeholder;
  }

  String getString({required StringRes string}) {
    return string;
  }

  // T getValues<T>({required T value}) {
  //   return value;
  // }
}
