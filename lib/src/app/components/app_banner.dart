import 'package:flutter/material.dart';

import '../../intl/package_localizations.dart';
import '../../utils/utils.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    if (WidgetUtil.showBanner) {
      result = Banner(
        message: PackageLocalizations.of(
          context,
        ).bannerTitle,
        location: BannerLocation.topStart,
        child: child,
      );
    }
    return result;
  }
}
