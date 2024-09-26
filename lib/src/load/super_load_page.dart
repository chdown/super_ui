import 'dart:async';

import 'package:flutter/widgets.dart';

/// 缺省页View需要混入的类
/// 仅支持混入[Widget]
mixin SuperLoadPage on Widget {
  /// 点击事件
  FutureOr Function(Map<String, String>? params)? onTap;

  /// 自定义参数
  Map<String, String>? params;
}
