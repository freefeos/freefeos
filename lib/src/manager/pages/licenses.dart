import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/window_buttons_overlay.dart';
import '../intl/app_localizations.dart';
import '../view_model/view_model.dart';

class LicensesPage extends StatefulWidget {
  const LicensesPage({super.key});

  static const String route = '/licenses';

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

class _LicensesPageState extends State<LicensesPage> {
  @override
  Widget build(BuildContext context) {
    return WindowButtonsOverlay(
      child: Consumer<ManagerViewModel>(
        builder: (context, viewModel, _) => FutureBuilder(
          future: viewModel.getAppName(),
          builder: (context, snapshot) {
            String appName = AppLocalizations.of(
              context,
            ).unknown;
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                appName = AppLocalizations.of(
                  context,
                ).waiting;
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  appName = AppLocalizations.of(
                    context,
                  ).error;
                  break;
                }
                if (snapshot.hasData) {
                  appName = snapshot.data ??
                      AppLocalizations.of(
                        context,
                      ).sNull;
                  break;
                }
                break;
              default:
                break;
            }
            return FutureBuilder(
              future: viewModel.getAppVersion(),
              builder: (context, snapshot) {
                String appVersion = AppLocalizations.of(
                  context,
                ).unknown;
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    appVersion = AppLocalizations.of(
                      context,
                    ).waiting;
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      appVersion = AppLocalizations.of(
                        context,
                      ).error;
                      break;
                    }
                    if (snapshot.hasData) {
                      appVersion = snapshot.data ??
                          AppLocalizations.of(
                            context,
                          ).sNull;
                      break;
                    }
                    break;
                  default:
                    break;
                }
                return LicensePage(
                  applicationName: appName,
                  applicationVersion: appVersion,
                  applicationLegalese: AppLocalizations.of(
                    context,
                  ).aboutDialogLegalese,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
