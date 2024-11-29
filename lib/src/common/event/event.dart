import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

class EventBuffer {
  static ListQueue<OutputEvent> outputEventBuffer = ListQueue();
}

class OutputEvent {
  final Level level;
  final List<String> lines;

  const OutputEvent(
    this.level,
    this.lines,
  );
}

class RenderedEvent {
  final int id;
  final Level level;
  final TextSpan span;
  final String lowerCaseText;

  const RenderedEvent(
    this.id,
    this.level,
    this.span,
    this.lowerCaseText,
  );
}
