part of '../framework.dart';

final class Want {
  Want({required this.classes});

  final dynamic classes;

  Service getService() {
    if (classes is Service) {
      return classes;
    } else {
      throw FlutterError('异常: 非Service类型!');
    }
  }
}
