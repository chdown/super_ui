import 'package:flutter/material.dart';

/// author : ch
/// true、false布局，用于处理三目运算符不便于阅读的问题
///
class SuperVisibility extends StatelessWidget {
  final bool visibility;
  final Widget trueWidget;
  final Widget falseWidget;

  const SuperVisibility({super.key, required this.visibility, required this.trueWidget, required this.falseWidget});

  @override
  Widget build(BuildContext context) {
    return visibility ? trueWidget : falseWidget;
  }
}
