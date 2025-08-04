part of '../manager.dart';

final class DetailsPage extends UiPage {
  const DetailsPage({super.key});

  static const RouteName route = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

final class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('详细信息')));
  }
}
