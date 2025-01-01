import 'package:flutter/material.dart';
import 'package:freefeos/src/manager/components/app_title.dart';
import 'package:provider/provider.dart';

import '../intl/app_localizations.dart';
import '../pages/about.dart';
import '../pages/manager.dart';
import '../view_model/view_model.dart';
import 'dialog_button.dart';
import 'exit_dialog.dart';

class MenuDialog extends StatefulWidget {
  const MenuDialog({
    super.key,
    this.isManager = false,
  });

  final bool? isManager;

  @override
  State<MenuDialog> createState() => _MenuDialogState();
}

class _MenuDialogState extends State<MenuDialog> {
  _MenuDialogState();

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // BottomSheet(onClosing: onClosing, builder: builder)
    return Consumer<ManagerViewModel>(
      builder: (context, viewModel, _) => Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Card.filled(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                      bottom: Radius.circular(12.0),
                    ),
                  ),
                  margin: EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                    bottom: 8,
                  ),
                  child: ListTile(
                    leading: const FlutterLogo(),
                    title: const AppTitle(),
                    subtitle: const AppSubTitle(),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pop();
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).pushNamed(
                        AboutPage.route,
                      );
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                        bottom: Radius.circular(12.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                  ),
                ),
                //Divider(height: 0),
                Expanded(
                  child: Card.filled(
                    margin: EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Scrollbar(
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Wrap(
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
                                  enabled: widget.isManager == false,
                                ),
                                DialogButton(
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();
                                    // showDialog(
                                    //   context: context,
                                    //   useRootNavigator: true,
                                    //   builder: (context) => AboutAlertDialog(),
                                    // );
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pushNamed(
                                      AboutPage.route,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text(
              'cancel',
              textAlign: TextAlign.center,
            ),
            onTap: () => Navigator.of(
              context,
              rootNavigator: true,
            ).pop(),
            contentPadding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            titleAlignment: ListTileTitleAlignment.center,
          ),
        ],
      ),
    );
  }
}

// /// 菜单
// class MenuDialog extends StatelessWidget {
//   const MenuDialog({
//     super.key,
//     this.isManager = false,
//   });

//   final bool? isManager;

//   @override
//   Widget build(BuildContext context) {

//     return Consumer<ManagerViewModel>(
//       builder: (context, viewModel, _) => AlertDialog(
//         title: Tooltip(
//           message: '打开管理器',
//           child: ListTile(
//             leading: FlutterLogo(),
//             title: FutureBuilder(
//               future: viewModel.getAppName(),
//               builder: (context, snapshot) {
//                 String text = AppLocalizations.of(
//                   context,
//                 ).unknown;
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     text = AppLocalizations.of(
//                       context,
//                     ).waiting;
//                     break;
//                   case ConnectionState.done:
//                     if (snapshot.hasError) {
//                       text = AppLocalizations.of(
//                         context,
//                       ).error;
//                       break;
//                     }
//                     if (snapshot.hasData) {
//                       text = snapshot.data ??
//                           AppLocalizations.of(
//                             context,
//                           ).sNull;
//                       break;
//                     }
//                     break;
//                   default:
//                     break;
//                 }
//                 return Text(text);
//               },
//             ),
//             subtitle: FutureBuilder(
//               future: viewModel.getAppVersion(),
//               builder: (context, snapshot) {
//                 String text = AppLocalizations.of(
//                   context,
//                 ).unknown;
//                 switch (snapshot.connectionState) {
//                   case ConnectionState.waiting:
//                     text = AppLocalizations.of(
//                       context,
//                     ).waiting;
//                     break;
//                   case ConnectionState.done:
//                     if (snapshot.hasError) {
//                       text = AppLocalizations.of(
//                         context,
//                       ).error;
//                       break;
//                     }
//                     if (snapshot.hasData) {
//                       text = snapshot.data ??
//                           AppLocalizations.of(
//                             context,
//                           ).sNull;
//                       break;
//                     }
//                     break;
//                   default:
//                     break;
//                 }
//                 return Text(text);
//               },
//             ),
//             trailing: Icon(Icons.keyboard_arrow_right),
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(28),
//                 topRight: Radius.circular(28),
//               ),
//             ),
//             contentPadding: const EdgeInsets.only(
//               left: 24,
//               top: 8,
//               right: 24,
//               bottom: 0,
//             ),
//             onTap: () {
//               Navigator.of(
//                 context,
//                 rootNavigator: true,
//               ).pop();
//               Navigator.of(
//                 context,
//                 rootNavigator: true,
//               ).pushNamed(
//                 AboutPage.route,
//               );
//             },
//           ),
//         ),
//         titlePadding: EdgeInsets.zero,
//         content: Wrap(
//           alignment: WrapAlignment.center,
//           children: <DialogButton>[
//             DialogButton(
//               onTap: () {
//                 Navigator.of(
//                   context,
//                   rootNavigator: true,
//                 ).pop();
//                 Navigator.of(
//                   context,
//                   rootNavigator: true,
//                 ).pushNamed(
//                   ManagerPage.route,
//                 );
//               },
//               icon: Icons.manage_accounts_outlined,
//               label: AppLocalizations.of(
//                 context,
//               ).bottomSheetManager,
//               tooltip: AppLocalizations.of(
//                 context,
//               ).bottomSheetManagerTooltip,
//               enabled: isManager == false,
//             ),
//             DialogButton(
//               onTap: () {
//                 Navigator.of(
//                   context,
//                   rootNavigator: true,
//                 ).pop();
//                 // showDialog(
//                 //   context: context,
//                 //   useRootNavigator: true,
//                 //   builder: (context) => AboutAlertDialog(),
//                 // );
//                 Navigator.of(
//                   context,
//                   rootNavigator: true,
//                 ).pushNamed(
//                   AboutPage.route,
//                 );
//               },
//               icon: Icons.info_outline,
//               label: '关于',
//               tooltip: '关于',
//               enabled: true,
//             ),
//             DialogButton(
//               onTap: () {
//                 Navigator.of(
//                   context,
//                   rootNavigator: true,
//                 ).pop();
//                 showDialog(
//                   context: context,
//                   useRootNavigator: true,
//                   builder: (context) => const ExitDialog(),
//                 );
//               },
//               icon: Icons.exit_to_app,
//               label: AppLocalizations.of(
//                 context,
//               ).bottomSheetExit,
//               tooltip: AppLocalizations.of(
//                 context,
//               ).bottomSheetExitToolTip,
//               enabled: true,
//             ),
//           ],
//         ),
//         actions: <Widget>[
//           Tooltip(
//             message: '关闭对话框',
//             child: TextButton(
//               onPressed: () => Navigator.of(
//                 context,
//                 rootNavigator: true,
//               ).pop(),
//               child: Text('取消'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
