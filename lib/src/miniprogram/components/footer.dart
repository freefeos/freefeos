part of '../miniprogram.dart';

enum FooterStyle { freefeos, ecosedkit, wechat, clock, calculator }

final class Footer extends UiComponent {
  const Footer({super.key, required this.style});

  /// 底部样式
  final FooterStyle style;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  /// 获取第一行文本
  String getFirst(BuildContext context) {
    switch (widget.style) {
      case FooterStyle.freefeos:
        return AppLocalizations.of(context).componentFooterMadeMPFlutter;
      case FooterStyle.ecosedkit:
        return AppLocalizations.of(context).componentFooterMadeUniAppX;
      case FooterStyle.wechat:
        return 'FreeFEOS 为运行在微信平台上的小程序';
      case FooterStyle.clock:
        return '此时间为24小时制';
      case FooterStyle.calculator:
        return '单击除清空键(C)外任意键开始计算';
    }
  }

  /// 获取第二行文本
  String getSecond(BuildContext context) {
    switch (widget.style) {
      case FooterStyle.freefeos:
        return Manifest.freefeos.icpId;
      case FooterStyle.ecosedkit:
        return Manifest.ecosedKit.icpId;
      case FooterStyle.wechat:
        return 'WeChat 及 微信 商标归腾讯公司所有';
      case FooterStyle.clock:
        return '此时间为操作系统时间';
      case FooterStyle.calculator:
        return '';
    }
  }

  /// 获取第三行文本
  String getLast(BuildContext context) {
    switch (widget.style) {
      case FooterStyle.freefeos:
      case FooterStyle.ecosedkit:
        final String currentYear = DateTime.now().year.toString();
        return AppLocalizations.of(
          context,
        ).componentFooterCopyright(currentYear);
      case FooterStyle.wechat:
        return '';
      case FooterStyle.clock:
        return '';
      case FooterStyle.calculator:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Text>[
          Text(
            getFirst(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            getSecond(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Text(
            getLast(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
