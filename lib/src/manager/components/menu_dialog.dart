import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../pages/info.dart';
import '../pages/manager.dart';
import '../view_model/view_model.dart';
import 'dialog_button.dart';
import 'about_dialog.dart';
import 'exit_dialog.dart';

/// 菜单
class MenuDialog extends StatelessWidget {
  const MenuDialog({
    super.key,
    required this.isManager,
  });

  final bool isManager;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, _) => AlertDialog(
        title: Tooltip(
          message: '打开管理器',
          child: ListTile(
            leading: FlutterLogo(),
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
            trailing: Icon(Icons.keyboard_arrow_right),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: 24,
              top: 8,
              right: 24,
              bottom: 0,
            ),
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop();
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(
                InfoPage.route,
              );
            },
          ),
        ),
        titlePadding: EdgeInsets.zero,
        content: Wrap(
          alignment: WrapAlignment.center,
          children: <DialogButton>[
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamed(
                  ManagerPage.route,
                );
              },
              icon: Icons.manage_accounts_outlined,
              label: AppLocalizations.of(
                context,
              ).bottomSheetManager,
              tooltip: AppLocalizations.of(
                context,
              ).bottomSheetManagerTooltip,
              enabled: !isManager,
            ),
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => AboutAlertDialog(),
                );
              },
              icon: Icons.info_outline,
              label: '关于',
              tooltip: '关于',
              enabled: true,
            ),
            DialogButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => const ExitDialog(),
                );
              },
              icon: Icons.exit_to_app,
              label: AppLocalizations.of(
                context,
              ).bottomSheetExit,
              tooltip: AppLocalizations.of(
                context,
              ).bottomSheetExitToolTip,
              enabled: true,
            ),
          ],
        ),
        actions: <Widget>[
          Tooltip(
            message: '关闭对话框',
            child: TextButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop(),
              child: Text('取消'),
            ),
          )
        ],
      ),
    );
  }
}
