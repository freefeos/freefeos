import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/view_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  static const String route = '/details';

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('更多资料'),
      ),
      body: Center(
        child: Consumer<ManagerViewModel>(
                builder: (context, viewModel, child) => Text(viewModel.pluginNames())),
      ),
    );
  }
}
