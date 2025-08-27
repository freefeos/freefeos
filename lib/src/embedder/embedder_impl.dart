part of 'embedder.dart';

final class OSEmbedder extends OSComponent {
  OSEmbedder();

  /// 服务实例
  late PlatformEmbedder _embedder;

  @override
  String get id {
    return resources.getValues(value: V.channels.connectChannel);
  }

  @override
  String get description {
    return resources.getValues(value: V.strings.embedderDescription);
  }

  @override
  String get title {
    return resources.getValues(value: V.strings.embedderTitle);
  }

  @override
  Future<void> onComponentAdded(ComponentBinding binding) {
    return super.onComponentAdded(binding).then((added) {
      final Want want = Want(classes: PlatformEmbedder());
      final EmbedderConnection connect = EmbedderConnection(
        calback: (embedder) => _embedder = embedder,
      );
      startService(want);
      bindService(want, connect);
      return added;
    });
  }

  @override
  void onComponentSyncMethodCall<T>(
    EngineMethodCall call,
    EngineResult<T> result,
  ) {
    result.notImplemented();
    // if (call.method == resources.getValues(value: 'getPackageName')) {
    //   result.syncSuccess(_embedder.getPackageName as T);
    // } else if (call.method == resources.getValues(value: 'getAppName')) {
    //   result.syncSuccess(_embedder.getAppName as T);
    // } else if (call.method == resources.getValues(value: 'getVersionName')) {
    //   result.syncSuccess(_embedder.getVersionName as T);
    // } else {
    //   result.notImplemented();
    // }

    // if (call.method ==
    //     resources.getValues(value: 'addThemeModeChangeListener')) {
    //   final dynamic callback = call.arguments['callback'];
    //   assert(callback != null && callback is VoidCallback);
    //   _embedder.addThemeModeChangeListener(callback as VoidCallback);
    //   result.syncSuccess(null);
    // } else if (call.method == resources.getValues(value: 'setClipboardData')) {
    //   final dynamic text = call.arguments['text'];
    //   assert(text != null && text is String);
    //   final dynamic showTips = call.arguments['showTips'];
    //   assert(showTips != null && showTips is VoidCallback);
    //   _embedder.setClipboardData(text as String, showTips as VoidCallback);
    //   result.syncSuccess(null);
    // } else if (call.method == resources.getValues(value: 'openSetting')) {
    //   final dynamic child = call.arguments['child'];
    //   assert(child != null && child is Widget);
    //   result.syncSuccess(_embedder.openSetting(child: child as Widget) as T);
    // } else if (call.method == resources.getValues(value: 'openCustomer')) {
    //   final dynamic child = call.arguments['child'];
    //   assert(child != null && child is Widget);
    //   result.syncSuccess(_embedder.openCustomer(child: child as Widget) as T);
    // } else if (call.method == resources.getValues(value: 'setAppShareInfo')) {
    //   final dynamic context = call.arguments['context'];
    //   assert(context != null && context is BuildContext);
    //   final dynamic title = call.arguments['title'];
    //   assert(title != null && title is String);
    //   final dynamic query = call.arguments['query'];
    //   assert(query != null && query is Map<dynamic, dynamic>);
    //   _embedder.setAppShareInfo(
    //     context: context as BuildContext,
    //     title: title as String,
    //     query: query as Map<dynamic, dynamic>,
    //   );
    //   result.syncSuccess(null);
    // } else if (call.method == resources.getValues(value: 'openEKit')) {
    //   final dynamic child = call.arguments['child'];
    //   assert(child != null && child is Widget);
    //   result.syncSuccess(_embedder.openEKit(child: child as Widget) as T);
    // } else if (call.method == resources.getValues(value: 'openWeChat')) {
    //   final dynamic child = call.arguments['child'];
    //   assert(child != null && child is Widget);
    //   result.syncSuccess(_embedder.openWeChat(child: child as Widget) as T);
    // } else if (call.method ==
    //     resources.getValues(value: 'getNavigatorObserver')) {
    //   result.syncSuccess(_embedder.getNavigatorObserver as T);
    // } else if (call.method == resources.getValues(value: 'getThemeMode')) {
    //   result.syncSuccess(_embedder.getThemeMode as T);
    // } else if (call.method == resources.getValues(value: 'getAppBarTheme')) {
    //   result.syncSuccess(_embedder.getAppBarTheme as T);
    // } else if (call.method == resources.getValues(value: 'checkEnv')) {
    //   result.syncSuccess(_embedder.checkEnv as T);
    // } else if (call.method == resources.getValues(value: 'getAppId')) {
    //   result.syncSuccess(_embedder.getAppId as T);
    // } else if (call.method == resources.getValues(value: 'getVersionStage')) {
    //   result.syncSuccess(_embedder.getVersionStage as T);
    // } else if (call.method == resources.getValues(value: 'getVersionName')) {
    //   result.syncSuccess(_embedder.getVersionName as T);
    // } else if (call.method == resources.getValues(value: 'getHostAppVersion')) {
    //   result.syncSuccess(_embedder.getHostAppVersion as T);
    // } else if (call.method == resources.getValues(value: 'getBaseSdkVersion')) {
    //   result.syncSuccess(_embedder.getBaseSdkVersion as T);
    // } else {
    //   result.notImplemented();
    // }
  }

  // @override
  // Future<void> onComponentAsyncMethodCall<T>(
  //   EngineMethodCall call,
  //   EngineResult<T> result,
  // ) async {
  //   if (call.method == resources.getValues(value: 'initDonutApi')) {
  //     await result.asyncSuccess(_embedder.initDonutApi() as T);
  //   } else if (call.method == resources.getValues(value: 'runDountApp')) {
  //     final dynamic app = call.arguments['app'];
  //     assert(app != null && app is Widget);
  //     result.asyncSuccess(_embedder.runDonutApp(app as Widget) as T);
  //   } else if (call.method == resources.getValues(value: 'initDelegate')) {
  //     result.asyncSuccess(_embedder.initDelegate() as T);
  //   } else {
  //     result.notImplemented();
  //   }
  // }
}
