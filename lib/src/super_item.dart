import 'package:flutter/material.dart';
import 'package:super_ui/src/super_icon.dart';

import 'super_popup.dart';
import 'super_text.dart';

/// @author : ch
/// @date 2024-04-24 14:04:31
/// @description 单行展示组件
///
class SuperItem extends StatelessWidget {
  /// 标题
  final String title;

  /// 标题文本颜色
  final Color titleColor;

  /// 标题文本大小
  final double titleSize;

  /// 子布局
  final Widget child;

  /// 提示文本
  final String? popText;

  /// 标题文本颜色
  final Color popTextColor;

  /// 标题文本大小
  final double popTextSize;

  /// 单位文本
  final String? unitText;

  /// 标题文本颜色
  final Color unitTextColor;

  /// 标题文本大小
  final double unitTextSize;

  /// 是否带*
  final bool mustForm;

  /// pop拦截器
  final bool Function() popInterceptor;

  const SuperItem({
    Key? key,
    required this.title,
    this.titleColor = const Color(0xFF333333),
    this.titleSize = 14,
    required this.child,
    required this.popInterceptor,
    this.popText,
    this.popTextColor = Colors.black,
    this.popTextSize = 12,
    this.unitText,
    this.unitTextColor = const Color(0xFF333333),
    this.unitTextSize = 14,
    this.mustForm = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SuperText(
              text: title,
              textSize: titleSize,
              textColor: titleColor,
            ),
            Visibility(
              visible: mustForm,
              child: const SuperText(
                text: '*',
                textColor: Colors.red,
                textSize: 14,
              ),
            ),
            if (popText != null && popText!.isNotEmpty) ...[
              const SizedBox(width: 5),
              SuperPopup(
                showInterceptor: popInterceptor,
                backgroundColor: Colors.white,
                content: SuperText(
                  text: popText!,
                  textColor: popTextColor,
                  textSize: popTextSize,
                  maxLines: 10,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SuperIcon.icon(
                    Icons.error_outline,
                    color: Colors.black,
                    size: 14,
                  ),
                ),
              )
            ]
          ],
        ),
        const SizedBox(width: 20),
        Expanded(child: child),
        if (unitText != null && unitText!.isNotEmpty) ...[
          const SizedBox(width: 10),
          SuperText(text: unitText!, textSize: unitTextSize, textColor: unitTextColor),
        ]
      ],
    );
  }
}
