part of '../common.dart';

class OutputEvent {
  final Level level;
  final List<String> lines;

  const OutputEvent(this.level, this.lines);
}
