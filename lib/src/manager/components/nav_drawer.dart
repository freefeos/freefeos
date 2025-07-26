part of '../manager.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({
    super.key,
    required this.navController,
    required this.header,
    required this.others,
  });

  final NavController navController;
  final Widget header;
  final List<Widget> others;

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  /// 导航列表
  final List<ListTile> _item = [];

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    List<UiScreen> destination = widget.navController.getDestinationList;
    for (var i = 0; i < destination.length; i++) {
      if (_item.isEmpty ||
          _item.any((element) {
            return (element.key as ValueKey).value !=
                widget.navController.getDestinationList[i].getIndex;
          })) {
        _item.insert(
          destination[i].getIndex,
          ListTile(
            key: ValueKey<int>(destination[i].getIndex),
            leading: Icon(destination[i].selectedIcon),
            title: Text(destination[i].label ?? 'unknown'),
            iconColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              widget.navController.destinationNotifier.value =
                  destination[i].getIndex;
            },
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _item.clear();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(child: widget.header),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Navigation',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Column(children: _item),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Divider(height: 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Other',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Column(children: widget.others),
          ],
        ),
      ),
    );
  }
}
