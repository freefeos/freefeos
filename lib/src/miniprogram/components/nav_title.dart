part of '../miniprogram.dart';

class NavTitle extends StatefulWidget {
  const NavTitle({super.key, required this.navController});

  final NavController navController;

  @override
  State<NavTitle> createState() => _NavTitleState();
}

class _NavTitleState extends State<NavTitle> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.navController.destinationNotifier,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text(
            widget.navController.getCurrentTitle,
            key: ValueKey<String>(widget.navController.getCurrentTitle),
          ),
        );
      },
    );
  }
}
