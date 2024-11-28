import 'package:flutter/material.dart';

import '../components/app_banner.dart';
import '../components/app_root_view.dart';
import '../components/system_dialog.dart';
import '../components/system_exit.dart';
import '../components/window_control_buttons.dart';
import '../utils/utils.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(
          builder: (_) => ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: AppBanner(
              child: AppRootView(),
            ),
          ),
        ),
        OverlayEntry(
          builder: (context) => Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.paddingOf(context).top,
                right: MediaQuery.paddingOf(context).right,
                left: MediaQuery.paddingOf(context).left,
              ),
              child: SizedBox(
                height: kToolbarHeight,
                child: PreferredSize(
                  preferredSize: const Size.fromHeight(
                    kToolbarHeight,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Visibility(
                        visible: WidgetUtil.kIsDesktopWithUI(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: WindowControlButtons(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
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
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
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
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
