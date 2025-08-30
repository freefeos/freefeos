part of '../manager.dart';

final class LicensesPage extends UiPage {
  const LicensesPage({super.key});

  static const RouteName route = "/licenses";

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

final class _LicensesPageState extends State<LicensesPage> {
  _LicensesPageState();

  /// 应用信息
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((res) {
      setState(() => _packageInfo = res);
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 清空应用信息
    _packageInfo = null;
  }

  @override
  Widget build(BuildContext context) {
    return LicensePage(
      applicationName: _packageInfo?.appName ?? 'Unknown',
      applicationVersion: _packageInfo?.version ?? 'Unknown',
      applicationLegalese: 'Powered by FreeFEOS',
    );
  }
}
