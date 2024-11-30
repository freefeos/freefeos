import 'package:flutter/material.dart';

import 'system_dialog.dart';
import 'system_exit.dart';

class MenuButtons extends StatelessWidget {
  const MenuButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: Row(
          children: [
            Tooltip(
              message: '系统菜单',
              child: InkWell(
                onTap: () => showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (_) => const SystemDialog(
                    isManager: false,
                  ),
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  child: Icon(
                    Icons.more_horiz,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
            VerticalDivider(
              indent: 6,
              endIndent: 6,
              width: 1,
              color: Colors.white.withOpacity(0.3),
            ),
            Tooltip(
              message: '退出应用',
              child: InkWell(
                onTap: () => showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (_) => const SystemExit(),
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  child: Icon(
                    Icons.adjust,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
