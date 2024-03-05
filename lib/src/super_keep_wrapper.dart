import 'package:flutter/material.dart';

class SupperKeepWrapper extends StatefulWidget {
  final Widget child;

  const SupperKeepWrapper({Key? key, required this.child}) : super(key: key);

  @override
  State<SupperKeepWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<SupperKeepWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
