part of '../manager.dart';

final class NavHost extends UiStatefulComponent {
  const NavHost({super.key, required this.navController});

  final NavController navController;

  @override
  State<NavHost> createState() => _NavHostState();
}

final class _NavHostState extends State<NavHost> {
  _NavHostState();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.navController.destinationNotifier,
      builder: (context, value, child) {
        return PageTransitionSwitcher(
          duration: Duration(milliseconds: 500),
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled,
              child: child,
            );
          },
          child: widget.navController.getDestinationList[value],
        );
      },
    );
  }
}
