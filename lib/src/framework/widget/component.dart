part of '../framework.dart';

abstract base class UiBasicComponent extends Widget {
  const UiBasicComponent({super.key});
}

/// 组件基类
abstract base class UiStatefulComponent extends StatefulWidget {
  const UiStatefulComponent({super.key});
}

abstract base class UiStatelessComponent extends StatelessWidget {
  const UiStatelessComponent({super.key});
}
