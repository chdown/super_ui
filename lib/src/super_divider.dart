import 'package:flutter/material.dart';

/// @author : ch
/// @description 用于分割页面组件元素的横向分割线
///
class SuperDivider extends StatelessWidget {
  /// 分割线的或者分割条的颜色配置默认颜色
  final Color color;

  /// 分割线的或者分割条的高度 默认0.5
  final double height;

  /// 是否展示为虚线
  final bool isDashed;

  /// 虚线长度
  final double dashSpace;

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
    this.isDashed = false,
    this.dashSpace = 5,
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
      child: isDashed
          ? CustomPaint(
              size: Size(double.infinity, height),
              painter: DashedLinePainter(
                color: color,
                height: height,
                dashWidth: dashSpace,
                dashSpace: dashSpace,
              ),
            )
          : Divider(
              thickness: height,
              height: height,
              color: color,
            ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double height;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    required this.color,
    required this.height,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
