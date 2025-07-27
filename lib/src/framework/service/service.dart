part of '../framework.dart';

abstract base class Service extends ContextWrapper {
  Service();
  void onCreate() {}
  IBinder onBind(Want want);
  bool onUnbind(Want want) => true;
  void onDestroy() {}
}
