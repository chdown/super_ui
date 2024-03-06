import 'dart:async';

/// 缺省页View需要混入的类
mixin SuperLoadPage{
  /// 点击事件
  FutureOr Function(Map<String, String>? params)? onTap;

  /// 自定义参数
  Map<String, String>? params;
}
