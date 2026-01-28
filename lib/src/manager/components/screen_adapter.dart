part of '../manager.dart';

final class ScreenAdapter extends UiStatefulComponent {
  const ScreenAdapter({super.key, required this.child});

  final Widget child;

  @override
  State<ScreenAdapter> createState() => _ScreenAdapterState();
}

class _ScreenAdapterState extends State<ScreenAdapter> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 840),
        child: widget.child,
      ),
    );
    // return SafeArea(
    //   left: true,
    //   top: false,
    //   right: true,
    //   bottom: false,
    //   minimum: EdgeInsets.zero,
    //   maintainBottomViewPadding: true,
    //   child: Align(
    //     alignment: Alignment.topCenter,
    //     child: ConstrainedBox(
    //       constraints: const BoxConstraints(maxWidth: 840),
    //       child: widget.child,
    //     ),
    //   ),
    // );
  }
}
