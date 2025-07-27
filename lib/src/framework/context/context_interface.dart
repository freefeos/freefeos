part of '../framework.dart';

abstract interface class IContent extends Context {
  void attachBuildContext(BuildContext context);
  void attachBaseContext(Context base);
  Context get baseContext;
  BuildContext get buildContext;
}
