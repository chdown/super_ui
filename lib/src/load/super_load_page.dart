import 'dart:async';

import 'package:flutter/widgets.dart';

/// 缺省页View需要混入的类
/// 仅支持混入[Widget]
mixin SuperLoadPage on Widget {
  /// 点击事件
  FutureOr Function(Map<String, String>? params)? onTap;

  /// 自定义参数
  Map<String, String>? params;

  static fast(Widget child) {
    return _LoadPage(child: child);
  }
}

class _LoadPage extends StatelessWidget with SuperLoadPage {
  final Widget child;

  _LoadPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
