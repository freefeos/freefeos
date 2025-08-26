part of '../manager.dart';

final class AboutPage extends UiPage {
  const AboutPage({super.key});

  static const RouteName route = '/about';

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    // 释放滚动控制器
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于应用'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(SettingsPage.route),
            icon: Icon(Icons.settings),
            tooltip: '设置',
          ),
        ],
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ScreenAdapter(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  Card.filled(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 16,
                      right: 16,
                      bottom: 8,
                    ),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Tooltip(
                      message: '应用',
                      child: ListTile(
                        leading: const FlutterLogo(),
                        title: Text('appName'),
                        subtitle: Text('appVersion'),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        onTap: () =>
                            Navigator.of(context).pushNamed(DetailsPage.route),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 16,
                  //     top: 8,
                  //     right: 16,
                  //     bottom: 8,
                  //   ),
                  //   child: Text('description'),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Tooltip(
                            message: '进入应用',
                            child: FilledButton(
                              onPressed: () => Navigator.of(
                                context,
                              ).popUntil(ModalRoute.withName(IndexPage.route)),
                              child: Text('进入应用'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Consumer<OSAbility>(
                            builder: (context, ability, child) {
                              return ability.openCustomer(
                                child: AppUtils.nonNullWidget(child: child),
                              );
                            },
                            child: SizedBox(
                              width: double.infinity,
                              child: Tooltip(
                                message: '管理器',
                                child: OutlinedButton(
                                  onPressed: () => Navigator.of(
                                    context,
                                  ).pushNamed(ManagerPage.route),
                                  child: Text('管理器'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card.filled(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: ListTile(
                      title: Text(
                        'Powered by FreeFEOS',
                        // textAlign: TextAlign.center,
                      ),
                      // titleAlignment: ListTileTitleAlignment.center,
                    ),
                  ),
                  Card.filled(
                    margin: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 8,
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('设置'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.settings,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const Icon(Icons.keyboard_arrow_right),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(SettingsPage.route);
                          },
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16),
                        Consumer<OSAbility>(
                          builder: (context, ability, child) {
                            return ability.openSetting(
                              child: AppUtils.nonNullWidget(child: child),
                            );
                          },
                          child: ListTile(
                            title: Text('开放源代码许可'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.list,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const Icon(Icons.keyboard_arrow_right),
                              ],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushNamed(LicensesPage.route);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      top: 8,
                      right: 16,
                      bottom: 16,
                    ),
                    child: Footer(style: FooterStyle.freefeos),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // body: Scrollbar(
      //   controller: _scrollController,
      //   child: ScreenAdapter(
      //     child: ScrollConfiguration(
      //       behavior: ScrollConfiguration.of(
      //         context,
      //       ).copyWith(scrollbars: false),
      //       child: SingleChildScrollView(
      //         controller: _scrollController,
      //         child: Column(
      //           children: [
      //             Card.filled(
      //               margin: const EdgeInsets.only(
      //                 left: 16,
      //                 top: 16,
      //                 right: 16,
      //                 bottom: 8,
      //               ),
      //               color: Theme.of(context).colorScheme.primaryContainer,
      //               child: ListTile(
      //                 leading: const FlutterLogo(),
      //                 title: Text('appName'),
      //                 subtitle: Text('appVersionName'),
      //                 trailing: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     Icon(
      //                       Icons.info_outline,
      //                       color: Theme.of(context).colorScheme.primary,
      //                     ),
      //                     const Icon(Icons.keyboard_arrow_right),
      //                   ],
      //                 ),
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12.0),
      //                 ),
      //                 contentPadding: const EdgeInsets.symmetric(
      //                   vertical: 12,
      //                   horizontal: 24,
      //                 ),
      //                 onTap: () =>
      //                     Navigator.of(context).pushNamed(DetailsPage.route),
      //               ),
      //             ),
      //             // Padding(
      //             //   padding: EdgeInsets.only(bottom: 8),
      //             //   child: ListTile(
      //             //     leading: const FlutterLogo(),
      //             //     title: Text('appName'),
      //             //     subtitle: Text('appVersionName'),
      //             //     trailing: Row(
      //             //       mainAxisSize: MainAxisSize.min,
      //             //       children: [
      //             //         Icon(
      //             //           Icons.info_outline,
      //             //           color: Theme.of(context).colorScheme.primary,
      //             //         ),
      //             //         const Icon(Icons.keyboard_arrow_right),
      //             //       ],
      //             //     ),
      //             //     contentPadding: const EdgeInsets.all(16),
      //             //     onTap: () =>
      //             //         Navigator.of(context).pushNamed(DetailsPage.route),
      //             //   ),
      //             // ),
      //             Padding(
      //               padding: EdgeInsets.only(
      //                 left: 16,
      //                 top: 8,
      //                 bottom: 8,
      //                 right: 16,
      //               ),
      //               child: Row(
      //                 children: [
      //                   Expanded(
      //                     child: Padding(
      //                       padding: EdgeInsets.only(right: 4.0),
      //                       child: FilledButton(
      //                         onPressed: () => Navigator.of(
      //                           context,
      //                         ).popUntil(ModalRoute.withName(IndexPage.route)),
      //                         child: Text('进入应用'),
      //                       ),
      //                     ),
      //                   ),
      //                   Expanded(
      //                     child: Padding(
      //                       padding: EdgeInsets.only(left: 4.0),
      //                       child: OutlinedButton(
      //                         onPressed: () => Navigator.of(
      //                           context,
      //                         ).pushNamed(ManagerPage.route),
      //                         child: Text('管理器'),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Card.filled(
      //               margin: const EdgeInsets.only(
      //                 left: 16,
      //                 top: 8,
      //                 bottom: 2,
      //                 right: 16,
      //               ),
      //               shape: const RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.vertical(
      //                   top: Radius.circular(12.0),
      //                   bottom: Radius.circular(6.0),
      //                 ),
      //               ),
      //               child: Tooltip(
      //                 message: '设置',
      //                 child: ListTile(
      //                   leading: Icon(Icons.settings),
      //                   title: Text('设置'),
      //                   onTap: () =>
      //                       Navigator.of(context).pushNamed(SettingsPage.route),
      //                   trailing: const Icon(Icons.keyboard_arrow_right),
      //                   contentPadding: const EdgeInsets.symmetric(
      //                     horizontal: 16.0,
      //                   ),
      //                   shape: const RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.vertical(
      //                       top: Radius.circular(12.0),
      //                       bottom: Radius.circular(6.0),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             Card.filled(
      //               margin: const EdgeInsets.only(
      //                 left: 16,
      //                 top: 2,
      //                 bottom: 16,
      //                 right: 16,
      //               ),
      //               shape: const RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.vertical(
      //                   top: Radius.circular(6.0),
      //                   bottom: Radius.circular(12.0),
      //                 ),
      //               ),
      //               child: Tooltip(
      //                 message: '开放源代码许可',
      //                 child: ListTile(
      //                   leading: Icon(Icons.add),
      //                   title: Text('开放源代码许可'),
      //                   onTap: () =>
      //                       Navigator.of(context).pushNamed(LicensesPage.route),
      //                   trailing: const Icon(Icons.keyboard_arrow_right),
      //                   contentPadding: const EdgeInsets.symmetric(
      //                     horizontal: 16.0,
      //                   ),
      //                   shape: const RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.vertical(
      //                       top: Radius.circular(6.0),
      //                       bottom: Radius.circular(12.0),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
