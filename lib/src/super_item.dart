import 'package:flutter/material.dart';
import 'package:super_ui/src/super_icon.dart';

import 'super_popup.dart';
import 'super_text.dart';

/// @author : ch
/// @date 2024-04-24 14:04:31
/// @description 单行展示组件
///
class SuperItem extends StatelessWidget {
  final String title;
  final Widget child;
  final bool Function() popInterceptor; // pop拦截器
  final String? popText;
  final String? unitText;
  final bool mustForm;

  const SuperItem({
    Key? key,
    required this.title,
    required this.child,
    required this.popInterceptor,
    this.popText,
    this.unitText,
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
              textSize: 14,
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
                  textColor: Colors.black,
                  textSize: 12,
                  maxLines: 10,
                ),
                child: SuperIcon.icon(
                  Icons.error_outline,
                  color: Colors.black,
                  size: 14,
                ),
              )
            ]
          ],
        ),
        const SizedBox(width: 20),
        Expanded(child: child),
        if (unitText != null && unitText!.isNotEmpty) ...[
          const SizedBox(width: 10),
          SuperText(text: unitText!),
        ]
      ],
    );
  }
}
