import 'package:flutter/material.dart';

import '../components/app_banner.dart';
import '../components/app_root_view.dart';
import '../components/window_app_bar.dart';

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
          builder: (_) => WindowAppBar(
            extern: true,
          ),
        ),
      ],
    );
  }
}
