import 'package:flutter/material.dart';

/// @author : ch
/// @description 文本加载组件
///
class SuperText extends StatelessWidget {
  /// 文字字符串
  final String text;

  /// 颜色
  final Color? textColor;

  /// 大小
  final double? textSize;

  /// 样式
  final TextStyle? textStyle;

  /// 重量
  final FontWeight? weight;

  /// 行数
  final int? maxLines;

  /// 自动换行
  final bool? softWrap;

  /// 溢出
  final TextOverflow? overflow;

  /// 对齐方式
  final TextAlign? textAlign;

  const SuperText({
    Key? key,
    required this.text,
    this.textStyle,
    this.maxLines = 1,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.textColor,
    this.textSize,
    this.weight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == "") {
      return const SizedBox();
    }
    return Text(
      text,
      style: textStyle?.copyWith(color: textColor, fontSize: textSize, fontWeight: weight) ??
          TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: weight,
          ),
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
