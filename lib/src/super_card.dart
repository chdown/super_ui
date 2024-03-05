import 'package:flutter/material.dart';

/// @author : ch
/// @date 2024-01-11 16:24:59
/// @description 卡片模式
///
class SuperCard extends StatelessWidget {
  /// 子布局
  final Widget child;

  /// 背景色
  final Color backgroundColor;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 布局方向
  final Alignment? alignment;

  /// 圆角
  final double radius;
  final double? topRadius;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomRadius;
  final double? bottomLeftRadius;
  final double? bottomRightRadius;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 内边距-
  final EdgeInsetsGeometry? padding;
  final double paddingHorizontal;
  final double paddingVertical;

  /// 局部阴影
  final List<BoxShadow>? boxShadow;

  const SuperCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.width,
    this.height,
    this.radius = 6,
    this.topRadius,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.alignment,
    this.margin,
    this.paddingHorizontal = 6,
    this.paddingVertical = 8,
    this.padding,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius ?? topLeftRadius ?? radius),
          topRight: Radius.circular(topRadius ?? topRightRadius ?? radius),
          bottomLeft: Radius.circular(bottomRadius ?? bottomLeftRadius ?? radius),
          bottomRight: Radius.circular(bottomRadius ?? bottomRightRadius ?? radius),
        ),
        color: backgroundColor,
        boxShadow: boxShadow,
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      margin: margin,
      child: child,
    );
  }
}
