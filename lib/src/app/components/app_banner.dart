import 'package:flutter/material.dart';

import '../intl/app_localizations.dart';
import '../utils/utils.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget result = child;
    if (AppUtils.showBanner) {
      result = Banner(
        message: AppLocalizations.of(
          context,
        ).bannerTitle,
        location: BannerLocation.topStart,
        child: child,
      );
    }
    return result;
  }
}
