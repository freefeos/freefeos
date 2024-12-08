import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../view_model/view_model.dart';

/// 退出对话框布局
class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, child) => AlertDialog(
        title: Text(
          AppLocalizations.of(
            context,
          ).closeDialogTitle,
        ),
        content: Text(
          AppLocalizations.of(
            context,
          ).closeDialogMessage,
        ),
        actions: [
          Tooltip(
            message: AppLocalizations.of(
              context,
            ).closeDialogCancelButton,
            child: TextButton(
              onPressed: () => Navigator.of(
                context,
                rootNavigator: true,
              ).pop(),
              child: Text(
                AppLocalizations.of(
                  context,
                ).closeDialogCancelButton,
              ),
            ),
          ),
          Tooltip(
            message: AppLocalizations.of(
              context,
            ).closeDialogExitButton,
            child: TextButton(
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                viewModel.exitApp();
              },
              child: Text(
                AppLocalizations.of(
                  context,
                ).closeDialogExitButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
