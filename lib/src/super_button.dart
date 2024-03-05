import 'package:flutter/material.dart';

enum ButtonType { filled, outlined, outlinedPrimary, text, textPrimary }

/// @author : ch
/// @description 按钮
///
class SuperButton extends StatelessWidget {
  /// 按钮点击的回调
  final VoidCallback onTap;

  /// 按钮显示的文案
  final ButtonType type;

  /// 按钮显示的文案
  final String? text;

  /// 按钮的文字颜色
  final Color? textColor;

  /// 按钮的文字大小
  final double? textSize;

  /// 按钮的文本显示样式 优先级高于[textColor]、[textSize]等属性
  final TextStyle? textStyle;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 自定义左侧Widget
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  /// 按钮背景色
  final Color? backgroundColor;

  /// 按钮不可用的文字颜色
  final Color? disableTextColor;

  /// 按钮不可用背景色
  final Color? disableBackgroundColor;

  /// 按钮外边距
  final EdgeInsetsGeometry? margin;

  /// 按钮内边距
  final EdgeInsetsGeometry? padding;
  final double? paddingHorizontal;
  final double? paddingVertical;

  /// 盒子阴影
  final List<BoxShadow>? boxShadow;

  /// 按钮的修饰 默认实色背景
  final Decoration? decoration;

  /// 按钮的布局约束 默认是自适应大小
  final BoxConstraints? constraints;

  /// 按钮的内部对齐 默认为null
  final Alignment? alignment;

  /// 按钮圆角大小
  final double borderRadius;

  /// 边框宽度
  final double borderWidth;

  /// 按钮是否可用 默认是 [true]
  final bool enabled;

  const SuperButton({
    Key? key,
    required this.onTap,
    required this.type,
    this.text,
    this.textColor,
    this.textSize,
    this.textStyle,
    this.width,
    this.height,
    this.prefixWidget,
    this.suffixWidget,
    this.backgroundColor,
    this.disableTextColor,
    this.disableBackgroundColor = const Color(0xFFCCCCCC),
    this.margin,
    this.padding,
    this.paddingHorizontal,
    this.paddingVertical,
    this.boxShadow,
    this.decoration,
    this.constraints,
    this.alignment,
    this.borderRadius = 6,
    this.borderWidth = 0.5,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor = this.backgroundColor;
    Color? textColor = this.textColor;
    Color? disableTextColor = this.disableTextColor;
    Color primaryColor = Theme.of(context).primaryColor;
    switch (type) {
      case ButtonType.filled:
        backgroundColor = backgroundColor ?? primaryColor;
        textColor = textColor ?? Colors.white;
        disableTextColor = disableTextColor ?? const Color(0xFF666666);
        break;
      case ButtonType.outlinedPrimary:
      case ButtonType.textPrimary:
        textColor = textColor ?? primaryColor;
        disableTextColor = textColor.withOpacity(0.2);
        break;
      case ButtonType.outlined:
      case ButtonType.text:
        textColor = textColor ?? const Color(0xFF666666);
        break;
    }

    return Material(
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
          if (enabled) onTap.call();
        },
        child: Container(
          width: width,
          height: height,
          margin: margin,
          alignment: alignment ?? (width != null ? Alignment.center : null),
          decoration: decoration ??
              BoxDecoration(
                color: enabled ? backgroundColor : disableBackgroundColor,
                border: (type == ButtonType.outlined || type == ButtonType.outlinedPrimary)
                    ? Border.all(color: type == ButtonType.outlinedPrimary ? Theme.of(context).primaryColor : const Color(0xFF999999), width: borderWidth)
                    : null,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: boxShadow,
              ),
          constraints: constraints,
          padding: EdgeInsets.symmetric(vertical: paddingVertical ?? 6, horizontal: paddingHorizontal ?? 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefixWidget != null) prefixWidget!,
              Text(text ?? "", overflow: TextOverflow.ellipsis, maxLines: 1, style: _getTextStyle(textColor), textAlign: TextAlign.center),
              if (suffixWidget != null) suffixWidget!,
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getTextStyle(Color? textColor) {
    if (textStyle != null) {
      return textStyle!;
    }
    Color? fontColor = enabled ? textColor : disableTextColor;
    return TextStyle(
      fontSize: textSize,
      color: fontColor,
    );
  }
}
