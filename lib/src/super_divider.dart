import 'package:flutter/material.dart';

/// @author : ch
/// @description 用于分割页面组件元素的横向分割线
///
class SuperDivider extends StatelessWidget {
  /// 分割线的或者分割条的颜色配置默认颜色
  final Color color;

  /// 分割线的或者分割条的高度 默认0.5
  final double height;

  /// 垂直缩进距离
  final double? verticalPadding;

  /// 左边缩进距离
  final double? topPadding;

  /// 右边缩进距离
  final double? bottomPadding;

  /// 水平缩进距离
  final double? horizontalPadding;

  /// 左边缩进距离
  final double? leftPadding;

  /// 右边缩进距离
  final double? rightPadding;

  const SuperDivider({
    Key? key,
    this.color = const Color(0xFFCCCCCC),
    this.height = 0.5,
    this.horizontalPadding,
    this.leftPadding,
    this.rightPadding,
    this.verticalPadding,
    this.topPadding,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: leftPadding ?? horizontalPadding ?? 0,
        right: rightPadding ?? horizontalPadding ?? 0,
        top: topPadding ?? verticalPadding ?? 0,
        bottom: bottomPadding ?? verticalPadding ?? 0,
      ),
      child: Divider(
        thickness: height,
        height: height,
        color: color,
      ),
    );
  }
}
