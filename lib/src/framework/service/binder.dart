part of '../framework.dart';

abstract base class Binder extends IBinder {
  @override
  Service get getService {
    throw UnimplementedError('异常: 未实现getService方法!');
  }
}
