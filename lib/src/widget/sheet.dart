import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intl/l10n.dart';
import '../values/route.dart';
import '../viewmodel/system_mmvm.dart';
import 'about.dart';
import 'exit.dart';

class SystemDialog extends StatelessWidget {
  const SystemDialog({
    super.key,
    required this.isManager,
  });

  final bool isManager;

  @override
  Widget build(BuildContext context) {
    return Consumer<SystemViewModel>(
      builder: (context, viewModel, _) => AlertDialog(
        title: ListTile(
          leading: FlutterLogo(),
          title: FutureBuilder(
            future: viewModel.getAppName(),
            builder: (context, snapshot) {
              String text = IntlLocalizations.of(
                context,
              ).unknown;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  text = IntlLocalizations.of(
                    context,
                  ).waiting;
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    text = IntlLocalizations.of(
                      context,
                    ).error;
                    break;
                  }
                  if (snapshot.hasData) {
                    text = snapshot.data ??
                        IntlLocalizations.of(
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
              String text = IntlLocalizations.of(
                context,
              ).unknown;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  text = IntlLocalizations.of(
                    context,
                  ).waiting;
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    text = IntlLocalizations.of(
                      context,
                    ).error;
                    break;
                  }
                  if (snapshot.hasData) {
                    text = snapshot.data ??
                        IntlLocalizations.of(
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
            showDialog(
              context: context,
              useRootNavigator: true,
              builder: (context) => SystemAbout(
                isPackage: false,
              ),
            );
          },
        ),
        titlePadding: EdgeInsets.zero,
        content: Wrap(
          alignment: WrapAlignment.center,
          children: <SheetButton>[
            SheetButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamed(routeManager);
              },
              icon: Icons.manage_accounts_outlined,
              label: IntlLocalizations.of(
                context,
              ).bottomSheetManager,
              tooltip: IntlLocalizations.of(
                context,
              ).bottomSheetManagerTooltip,
              enabled: !isManager,
            ),
            SheetButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => const SystemAbout(
                    isPackage: false,
                  ),
                );
              },
              icon: Icons.info_outline,
              label: '关于',
              tooltip: '关于',
              enabled: true,
            ),
            SheetButton(
              onTap: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop();
                showDialog(
                  context: context,
                  useRootNavigator: true,
                  builder: (context) => const SystemExit(),
                );
              },
              icon: Icons.exit_to_app,
              label: IntlLocalizations.of(
                context,
              ).bottomSheetExit,
              tooltip: IntlLocalizations.of(
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

class SheetButton extends StatelessWidget {
  const SheetButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.enabled,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String label;
  final String tooltip;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            child: Tooltip(
              message: tooltip,
              child: InkWell(
                onTap: enabled ? onTap : null,
                canRequestFocus: enabled,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12.0),
                ),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: Center(
                    child: Opacity(
                      opacity: enabled ? 1 : 0.5,
                      child: Icon(
                        icon,
                        size: Theme.of(context).iconTheme.size,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Opacity(
              opacity: enabled ? 1 : 0.5,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
