import 'package:flutter/material.dart';
import 'package:super_ui/src/sliver/rendering.dart';

/// @author : ch
/// @date 2024-08-05 10:29:06
/// @description SliverPinnedToBoxAdapter
///
/// A pinned sliver that contains a single box widget.
///
/// Slivers are special-purpose widgets that can be combined using a
/// [CustomScrollView] to create custom scroll effects. A [SliverToBoxAdapter]
/// is a basic sliver that creates a bridge back to one of the usual box-based
/// widgets.
///
/// Rather than using multiple [SliverToBoxAdapter] widgets to display multiple
/// box widgets in a [CustomScrollView], consider using [SliverList],
/// [SliverFixedExtentList], [SliverPrototypeExtentList], or [SliverGrid],
/// which are more efficient because they instantiate only those children that
/// are actually visible through the scroll view's viewport.
class SliverPinnedToBoxAdapter extends SingleChildRenderObjectWidget {
  /// Creates a pinned sliver that contains a single box widget.
  const SliverPinnedToBoxAdapter({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderSliverPinnedToBoxAdapter createRenderObject(BuildContext context) => RenderSliverPinnedToBoxAdapter();
}
