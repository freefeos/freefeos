part of '../manager.dart';

class SystemSheet extends StatefulWidget {
  const SystemSheet({super.key});

  @override
  State<SystemSheet> createState() => _SystemSheetState();
}

class _SystemSheetState extends State<SystemSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      showDragHandle: true,
      onClosing: () {},
      builder: (context) {
        return FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(ManagerPage.route);
          },
          child: Text('Manager'),
        );
      },
    );
  }
}
