part of '../manager.dart';

class CapsuleButton extends StatelessWidget {
  const CapsuleButton({
    super.key,
    required this.firstIcon,
    required this.lastIcon,
    required this.firstTooltip,
    required this.lastTooltip,
    required this.onFirstTap,
    required this.onLastTap,
    required this.child,
  });

  final IconData firstIcon;
  final IconData lastIcon;
  final String firstTooltip;
  final String lastTooltip;
  final VoidCallback onFirstTap;
  final VoidCallback onLastTap;
  final Widget child;

  /// 胶囊按钮宽度
  final double _width = 87.0;

  /// 胶囊按钮高度
  final double _height = 32.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: child,
        ),
        SafeArea(
          left: false,
          top: true,
          right: true,
          bottom: false,
          child: Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(
                (Theme.of(context).appBarTheme.toolbarHeight ??
                        kToolbarHeight - _height) /
                    2,
              ),
              child: Container(
                width: _width,
                height: _height,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white.withAlpha((255 * 0.6).toInt())
                      : Colors.black.withAlpha((255 * 0.15).toInt()),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 0.5,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black.withAlpha(25)
                        : Colors.white.withAlpha(25),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Tooltip(
                          message: firstTooltip,
                          child: InkWell(
                            onTap: onFirstTap,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Opacity(
                                  opacity:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? 1.0
                                      : 0.8,
                                  child: Icon(
                                    firstIcon,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        indent: 6,
                        endIndent: 6,
                        width: 0.2,
                        thickness: 0.2,
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black.withAlpha((255 * 0.3).toInt())
                            : Colors.white.withAlpha((255 * 0.3).toInt()),
                      ),
                      Expanded(
                        child: Tooltip(
                          message: lastTooltip,
                          child: InkWell(
                            onTap: onLastTap,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Opacity(
                                  opacity:
                                      Theme.of(context).brightness ==
                                          Brightness.light
                                      ? 1.0
                                      : 0.8,
                                  child: Icon(
                                    lastIcon,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
