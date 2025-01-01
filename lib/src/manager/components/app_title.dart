import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../view_model/view_model.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) => FutureBuilder(
        future: viewModel.getAppName(),
        builder: (context, snapshot) {
          String text = AppLocalizations.of(
            context,
          ).unknown;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              text = AppLocalizations.of(
                context,
              ).waiting;
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                text = AppLocalizations.of(
                  context,
                ).error;
                break;
              }
              if (snapshot.hasData) {
                text = snapshot.data ??
                    AppLocalizations.of(
                      context,
                    ).sNull;
                break;
              }
              break;
            default:
              break;
          }
          return Text(text);
        },
      ),
    );
  }
}

class AppSubTitle extends StatelessWidget {
  const AppSubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) => FutureBuilder(
        future: viewModel.getAppVersion(),
        builder: (context, snapshot) {
          String text = AppLocalizations.of(
            context,
          ).unknown;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              text = AppLocalizations.of(
                context,
              ).waiting;
              break;
            case ConnectionState.done:
              if (snapshot.hasError) {
                text = AppLocalizations.of(
                  context,
                ).error;
                break;
              }
              if (snapshot.hasData) {
                text = snapshot.data ??
                    AppLocalizations.of(
                      context,
                    ).sNull;
                break;
              }
              break;
            default:
              break;
          }
          return Text(text);
        },
      ),
    );
  }
}
