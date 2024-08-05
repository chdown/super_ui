import 'package:flutter/material.dart';
import 'package:super_ui/src/sliver/widget.dart';

/// @author : ch
/// @date 2024-08-05 10:28:41
/// @description SliverPinnedPersistentHeader
///
/// A sliver whose size varies when the sliver is scrolled to the leading edge
/// of the viewport.
///
/// This is the layout primitive that [ExtendedSliverAppbar] uses for its
/// shrinking/growing effect.
class SliverPinnedPersistentHeader extends StatelessWidget {
  /// Creates a sliver that varies its size when it is scrolled to the start of
  /// a viewport.
  ///
  /// The [delegate] must not be null.
  const SliverPinnedPersistentHeader({required this.delegate});

  final SliverPinnedPersistentHeaderDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return SliverPinnedPersistentHeaderRenderObjectWidget(delegate);
  }
}
