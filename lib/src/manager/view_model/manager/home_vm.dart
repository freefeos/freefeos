part of '../../manager.dart';

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

final class HomeViewModel with ViewModel implements IHomeViewModel {
  HomeViewModel();

  @override
  Color getStateCardColor(BuildContext context, OSAbility ability) {
    return Theme.of(context).colorScheme.primaryContainer;
    // return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
    //     ? Theme.of(context).colorScheme.errorContainer
    //     : Theme.of(context).colorScheme.primaryContainer;
  }

  @override
  IconData getStateCardIcon(OSAbility ability) {
    return Icons.check_circle_outline;
    // return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
    //     ? Icons.error_outline
    //     : Icons.check_circle_outline;
  }

  @override
  String getStateCardTitle(BuildContext context, OSAbility ability) {
    return '工作中';
    // return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
    //     ? '环境异常'
    //     : '工作中';
  }

  @override
  String getStateCardEnv(BuildContext context, OSAbility ability) {
    if (ability.checkEnv) {
      switch (ability.getVersionStage) {
        case 'develop':
          return '开发版';
        case 'trial':
          return '体验版';
        case 'release':
          return '正式版';
        default:
          return '未知版本';
      }
    } else {
      return 'Flutter';
    }
  }
}
