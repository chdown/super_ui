import 'package:flutter/material.dart';

/// @author : ch
/// @description 文本加载组件
///
class SuperRichText extends StatelessWidget {
  /// 文字字符串
  final String? title;

  /// 颜色
  final Color? titleColor;

  /// 大小
  final double? titleSize;

  /// 样式
  final TextStyle? titleStyle;

  /// 重量
  final FontWeight? titleWeight;

  /// 文字字符串
  final String? text;

  /// 颜色
  final Color textColor;

  /// 大小
  final double? textSize;

  /// 样式
  final TextStyle? textStyle;

  /// 重量
  final FontWeight? textWeight;

  /// 行数
  final int? maxLines;

  /// 自动换行
  final bool softWrap;

  /// 溢出
  final TextOverflow overflow;

  /// 对齐方式
  final TextAlign textAlign;

  /// 扩展类型
  final List<TextSpan> spanList;

  const SuperRichText({
    Key? key,
    this.title,
    this.titleColor = const Color(0xFF666666),
    this.titleSize,
    this.titleStyle,
    this.titleWeight,
    this.text,
    this.textColor = const Color(0xFF333333),
    this.textSize,
    this.textStyle,
    this.textWeight,
    this.maxLines,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.spanList = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ((title == null || title == '') && (text == null || text == '')) {
      return const SizedBox();
    }
    return RichText(
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      textAlign: textAlign,
      text: TextSpan(
        text: title,
        style: titleStyle?.copyWith(color: titleColor, fontSize: titleSize, fontWeight: titleWeight) ??
            TextStyle(
              color: titleColor,
              fontSize: titleSize,
              fontWeight: titleWeight,
            ),
        children: [
          TextSpan(
            text: text,
            style: textStyle?.copyWith(color: textColor, fontSize: textSize, fontWeight: textWeight) ??
                TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontWeight: textWeight,
                ),
          ),
          for (var span in spanList) span
        ],
      ),
    );
  }
}
