import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../pages/licenses.dart';
import '../view_model/view_model.dart';

class AboutAlertDialog extends StatelessWidget {
  const AboutAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, _) => AlertDialog(
        title: ListTile(
          title: FutureBuilder(
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
          subtitle: FutureBuilder(
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
          contentPadding: EdgeInsets.only(
            left: 24,
            top: 8,
            right: 24,
            bottom: 0,
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: Text(
          AppLocalizations.of(
            context,
          ).aboutDialogLegalese,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop();
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                LicensesPage.route,
              );
            },
            child: Text('开放源代码许可'),
          ),
          TextButton(
            onPressed: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(),
            child: Text('取消'),
          ),
        ],
      ),
    );
  }
}
