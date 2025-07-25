part of '../standard.dart';

/// SDK 调用
extension FreeFEOSSdkExt on IfeOSdk {
  // FreeFEOS Sdk
  FreeFEOSSdk get fe => FreeFEOSSdk(getSdkInvoker);
}
