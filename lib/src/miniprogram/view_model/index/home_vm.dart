part of '../../miniprogram.dart';

final class HomeViewModel with ViewModel implements IHomeViewModel {
  HomeViewModel();

  @override
  Color getStateCardColor(BuildContext context, OSAbility ability) {
    return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
        ? Theme.of(context).colorScheme.errorContainer
        : Theme.of(context).colorScheme.primaryContainer;
  }

  @override
  IconData getStateCardIcon(OSAbility ability) {
    return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
        ? Icons.error_outline
        : Icons.check_circle_outline;
  }

  @override
  String getStateCardTitle(BuildContext context, OSAbility ability) {
    return ability.checkEnv && ability.getAppId != Manifest.freefeos.appId
        ? '环境异常'
        : '工作中';
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
