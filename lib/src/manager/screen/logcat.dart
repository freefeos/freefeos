import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../common/event/event.dart';
import '../../framework/ansi_parser.dart';
import '../components/screen_adapter.dart';
import '../intl/app_localizations.dart';
import '../utils/utils.dart';

/// 日志页面布局
class LogcatScreen extends StatefulWidget {
  const LogcatScreen({super.key});

  @override
  State<LogcatScreen> createState() => _LogcatScreenState();
}

class _LogcatScreenState extends State<LogcatScreen> {
  final ListQueue<RenderedEvent> _renderedBuffer = ListQueue();
  final ScrollController _scrollController = ScrollController();
  final StringBuffer _logs = StringBuffer('Start: ');
  List<RenderedEvent> _filteredBuffer = [];

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _renderedBuffer.clear();
    for (var event in EventBuffer.outputEventBuffer) {
      final IAnsiParser parser = AnsiParser(
        context: context,
        showTips: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(
                context,
              ).managerLogCopyTips,
            ),
          ),
        ),
      );
      final String text = event.lines.join('\n');
      int currentId = 0;
      parser.parse(text);
      _renderedBuffer.add(
        RenderedEvent(
          currentId++,
          event.level,
          TextSpan(children: parser.getSpans),
          text.toLowerCase(),
        ),
      );
    }
    setState(
      () => _filteredBuffer = _renderedBuffer.where(
        (it) {
          if (it.level.value < Level.CONFIG.value) {
            return false;
          } else {
            return true;
          }
        },
      ).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _logs.clear();
    return ScreenAdapter(
      child: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          itemCount: _filteredBuffer.length,
          itemBuilder: (context, index) {
            final RenderedEvent logEntry = _filteredBuffer[index];
            _logs.write("${logEntry.lowerCaseText}\n");
            return Text.rich(
              logEntry.span,
              key: Key(logEntry.id.toString()),
              style: TextStyle(
                fontSize: 14,
                color: AppUtils.level2Color(
                  logEntry.level,
                  context,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
