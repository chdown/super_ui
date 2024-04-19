import 'package:flutter/material.dart';
import 'package:super_ui/src/super_text.dart';

/// @author : ch
/// @date 2024-01-18 14:12:02
/// @description Item列表
///
enum ItemTextType { none, outline }

enum ItemHitType { none, select, input }

enum ItemIconType { none, right, date, down }

class SuperItemText extends StatelessWidget {
  /// 标题自定义widget
  final Widget? titleWidget;

  /// 标题
  final String? title;

  /// 标题文本颜色
  final Color? titleColor;

  /// 标题文本大小
  final double titleSize;

  /// 文本
  final String? text;

  /// 文本颜色
  final Color? textColor;

  /// 文本大小
  final double textSize;

  /// 文本对齐方向
  final TextAlign? textAlign;

  /// 行数
  final int maxLines;

  /// 提示文本
  final String? hintText;

  /// 背景se
  final Color? backgroundColor;

  /// 圆角大小
  final double? borderRadius;

  /// 圆角颜色
  final Color? borderColor;

  /// 圆角宽度
  final double? borderWidth;

  /// 点击事件
  final Function(String? content)? onTap;

  /// 高度
  final double? height;

  /// 内边距
  final EdgeInsets? padding;

  /// 自定义
  final Widget? custom;

  /// 是否启用
  final bool enable;

  /// 样式
  final ItemTextType itemType;

  /// 提示样式
  final ItemHitType itemHitType;

  /// 图标样式
  final ItemIconType itemIconType;

  const SuperItemText({
    super.key,
    this.titleWidget,
    this.title,
    this.titleColor,
    this.titleSize = 15,
    this.text,
    this.textColor,
    this.textSize = 15,
    this.textAlign = TextAlign.right,
    this.maxLines = 1,
    this.hintText,
    this.backgroundColor,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.height = 50,
    this.padding,
    this.custom,
    this.enable = true,
    this.itemType = ItemTextType.none,
    this.itemHitType = ItemHitType.none,
    this.itemIconType = ItemIconType.right,
  });

  @override
  Widget build(BuildContext context) {
    String hintTextStr = hintText ?? "";
    if (hintTextStr.isEmpty && itemHitType == ItemHitType.select) {
      hintTextStr = "请选择$title";
    } else if (hintTextStr.isEmpty && itemHitType == ItemHitType.input) {
      hintTextStr = "请输入$title";
    }
    double? borderRadius = this.borderRadius;
    Color? borderColor = this.borderColor;
    double? borderWidth = this.borderWidth;
    if (itemType == ItemTextType.none) {
      borderRadius ??= 0;
      borderWidth ??= 0;
      borderColor ??= Colors.transparent;
    } else if (itemType == ItemTextType.outline) {
      borderRadius ??= 6;
      borderWidth ??= 1;
      borderColor ??= const Color(0xFF999999);
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (enable) onTap?.call(text ?? "");
      },
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius!),
          border: Border.all(color: borderColor!, width: borderWidth!),
        ),
        child: GestureDetector(
          child: Row(
            children: [
              titleWidget ??
                  SuperText(
                    text: title ?? "",
                    textColor: enable ? (titleColor ?? const Color(0xFF666666)) : const Color(0xFF999999),
                    textSize: titleSize,
                  ),
              const SizedBox(width: 6),
              Expanded(
                child: SuperText(
                  text: (text != null && text != '') ? text! : hintTextStr,
                  textColor: (enable && (text != null && text!.isNotEmpty)) ? (textColor ?? const Color(0xFF666666)) : const Color(0xFF999999),
                  textSize: textSize,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  textAlign: textAlign,
                ),
              ),
              Visibility(
                visible: custom != null,
                child: custom ?? const SizedBox.shrink(),
              ),
              Visibility(
                visible: itemIconType == ItemIconType.right && onTap != null,
                child: Icon(
                  Icons.chevron_right_outlined,
                  color: Color(enable ? 0xFF666666 : 0xFF999999),
                ),
              ),
              Visibility(
                visible: itemIconType == ItemIconType.date && onTap != null,
                child: Icon(
                  Icons.date_range,
                  color: Color(enable ? 0xFF666666 : 0xFF999999),
                ),
              ),
              Visibility(
                visible: itemIconType == ItemIconType.down && onTap != null,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Color(enable ? 0xFF666666 : 0xFF999999),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
