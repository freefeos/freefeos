part of '../manager.dart';

class SystemSheet extends StatefulWidget {
  const SystemSheet({super.key});

  @override
  State<SystemSheet> createState() => _SystemSheetState();
}

class _SystemSheetState extends State<SystemSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            children: [
              Card.filled(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 0,
                  right: 16,
                  bottom: 8,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  leading: const FlutterLogo(),
                  title: Text('appName'),
                  subtitle: Text('subtitle'),
                  trailing: const Icon(Icons.arrow_right_rounded),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  onTap: () => Navigator.of(context, rootNavigator: false)
                    ..pop()
                    ..pushNamed(ManagerPage.route),
                ),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context, rootNavigator: false)
                  ..pop()
                  ..pushNamed(AboutPage.route),
                child: Text('About'),
              ),
            ],
          ),
        ),
        Divider(height: 1),
        ListTile(
          onTap: () => Navigator.of(context, rootNavigator: false).pop(),
          title: Text('Cancel', textAlign: TextAlign.center),
          textColor: Theme.of(context).colorScheme.primary,
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
        ),
      ],
    );
  }
}
