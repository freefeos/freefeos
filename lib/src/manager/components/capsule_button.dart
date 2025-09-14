part of '../manager.dart';

/// 胶囊按钮
final class CapsuleButton extends UiStatefulComponent {
  const CapsuleButton({
    super.key,
    required this.leadingIcon,
    required this.leadingTooltip,
    required this.onLeadingTap,
    required this.trailingIcon,
    required this.trailingTooltip,
    required this.onTrailingTap,
    required this.child,
  });

  /// 左侧按钮图标
  final IconData leadingIcon;

  /// 左侧按钮提示
  final String leadingTooltip;

  /// 左侧按钮点击事件
  final VoidCallback onLeadingTap;

  /// 右侧按钮图标
  final IconData trailingIcon;

  /// 右侧按钮提示
  final String trailingTooltip;

  /// 右侧按钮点击事件
  final VoidCallback onTrailingTap;

  /// 子组件
  final Widget child;

  @override
  State<CapsuleButton> createState() => _CapsuleButtonState();
}

final class _CapsuleButtonState extends State<CapsuleButton> {
  _CapsuleButtonState();

  // 胶囊按钮宽度
  static final double _width = 87.0;
  // 胶囊按钮高度
  static final double _height = 32.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: widget.child,
        ),
        SafeArea(
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
                          message: widget.leadingTooltip,
                          child: InkWell(
                            onTap: widget.onLeadingTap,
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
                                    widget.leadingIcon,
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
                          message: widget.trailingTooltip,
                          child: InkWell(
                            onTap: widget.onTrailingTap,
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
                                    widget.trailingIcon,
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
