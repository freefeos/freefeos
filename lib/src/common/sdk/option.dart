import 'package:flutter/material.dart';

import '../types/types.dart';

abstract interface class IAppOption {
  Map<RouteName, WidgetBuilder> buildPages();
  ThemeData buildStyle(BuildContext context);
  String buildTitle(BuildContext context);
  ViewModel buildViewModel(BuildContext context);
}
