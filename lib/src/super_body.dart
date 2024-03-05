import 'package:flutter/material.dart';

/// @author : ch
/// @description body布局
///
class SuperBody extends StatelessWidget {
  final Widget? topBody;
  final Widget body;
  final Widget? bottomBody;

  const SuperBody({super.key, required this.body, this.topBody, this.bottomBody});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (topBody != null) topBody!,
        Expanded(child: body),
        if (bottomBody != null) bottomBody!,
      ],
    );
  }
}
