part of '../manager.dart';

final class NavBar extends UiComponent {
  const NavBar({super.key, required this.navController});

  final NavController navController;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final List<NavigationDestination> _tabs = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    List<UiScreen> destination = widget.navController.getDestinationList;
    for (var i = 0; i < destination.length; i++) {
      if (_tabs.isEmpty ||
          _tabs.any((element) {
            return element.label !=
                widget.navController.getDestinationList[i].label;
          })) {
        _tabs.insert(
          destination[i].getIndex,
          NavigationDestination(
            icon: Icon(destination[i].icon),
            selectedIcon: Icon(destination[i].selectedIcon),
            label: destination[i].label ?? '',
            tooltip: destination[i].label ?? '',
            enabled: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.navController.destinationNotifier,
      builder: (context, value, child) {
        return NavigationBar(
          animationDuration: Duration(milliseconds: 500),
          destinations: _tabs,
          selectedIndex:
              widget.navController.getDestinationList[value].getIndex,
          onDestinationSelected: (index) {
            widget.navController.destinationNotifier.value =
                widget.navController.getDestinationList[index].getIndex;
          },
        );
      },
    );
  }
}
