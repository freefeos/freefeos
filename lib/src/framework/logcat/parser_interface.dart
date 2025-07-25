part of '../framework.dart';

abstract interface class IAnsiParser {
  List<TextSpan> get getSpans;
  void parse(String string);
}
