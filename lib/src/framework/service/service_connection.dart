part of '../framework.dart';

abstract interface class ServiceConnection {
  void onServiceConnected(String name, IBinder service);
  void onServiceDisconnected(String name);
}
