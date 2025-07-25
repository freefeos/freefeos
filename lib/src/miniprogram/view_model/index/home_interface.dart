part of '../../miniprogram.dart';

abstract interface class IHomeViewModel {
  /// 状态卡片颜色
  Color getStateCardColor(BuildContext context, OSAbility ability);

  /// 状态卡片图标
  IconData getStateCardIcon(OSAbility ability);

  /// 状态卡片标题
  String getStateCardTitle(BuildContext context, OSAbility ability);

  /// 状态卡片环境版本
  String getStateCardEnv(BuildContext context, OSAbility ability);
}
