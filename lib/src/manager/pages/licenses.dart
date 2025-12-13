part of '../manager.dart';

final class LicensesPage extends UiPage {
  const LicensesPage({super.key});

  static const RouteName route = "/licenses";

  @override
  State<LicensesPage> createState() => _LicensesPageState();
}

final class _LicensesPageState extends State<LicensesPage> {
  _LicensesPageState();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) => LicensePage(
        applicationName: snapshot.data?.appName ?? 'Unknown',
        applicationVersion: snapshot.data?.version ?? 'Unknown',
        applicationLegalese: 'Powered by FreeFEOS',
      ),
    );
  }
}
