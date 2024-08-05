import 'package:flutter/material.dart';
import 'package:super_ui/src/sliver/sliver_pinned_persistent_header_.dart';

import 'widget.dart';

/// @author : ch
/// @date 2024-08-05 10:29:33
/// @description ExtendedSliverAppbar
///
/// A material design app bar that integrates with a [CustomScrollView].
/// See more [SliverPinnedPersistentHeader].
class ExtendedSliverAppbar extends StatelessWidget {
  const ExtendedSliverAppbar({
    this.leading,
    this.title,
    this.actions,
    this.background,
    this.toolBarColor,
    this.onBuild,
    this.statusbarHeight,
    this.toolbarHeight,
    this.isOpacityFadeWithToolbar = true,
    this.isOpacityFadeWithTitle = true,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.opacityShow = 0,
  });

  /// A widget to display before the [title].
  final Widget? leading;

  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final Widget? title;

  /// Widgets to display after the [title] widget.
  final Widget? actions;

  /// A Widget to display behind [leading],[title],[actions].
  final Widget? background;

  /// Background color for Row(leading,title,background).
  final Color? toolBarColor;

  /// Call when re-build on scroll.
  final OnSliverPinnedPersistentHeaderDelegateBuild? onBuild;

  /// Height of Toolbar. Default value : kToolbarHeight
  final double? toolbarHeight;

  /// Height of Statusbar. Default value : MediaQuery.of(context).padding.top
  final double? statusbarHeight;

  /// Whether do an opacity fade for toolbar.
  ///
  /// By default, the value of isOpacityFadeWithToolbar is true.
  final bool isOpacityFadeWithToolbar;

  /// Whether do an opacity fade for title.
  ///
  /// By default, the value of isOpacityFadeWithTitle is true.
  final bool isOpacityFadeWithTitle;

  /// MainAxisAlignment of toolbar
  ///
  /// By default, the value of mainAxisAlignment is MainAxisAlignment.spaceBetween.
  final MainAxisAlignment mainAxisAlignment;

  /// CrossAxisAlignment of toolbar
  ///
  /// By default, the value of crossAxisAlignment is CrossAxisAlignment.center.
  final CrossAxisAlignment crossAxisAlignment;

  /// author ch
  /// 控制内容展示时机，为1最终才展示，为0默认占用空间
  final double opacityShow;

  @override
  Widget build(BuildContext context) {
    final SafeArea? safeArea = context.findAncestorWidgetOfExactType<SafeArea>();
    double? statusbarHeight = this.statusbarHeight;
    final double toolbarHeight = this.toolbarHeight ?? kToolbarHeight;
    if (statusbarHeight == null && (safeArea == null || !safeArea.top)) {
      statusbarHeight = MediaQuery.of(context).padding.top;
    }
    statusbarHeight ??= 0;
    final Widget toolbar = SizedBox(
      height: toolbarHeight + statusbarHeight,
    );

    return SliverPinnedPersistentHeader(
      delegate: _ExtendedSliverAppbarDelegate(
        minExtentProtoType: toolbar,
        maxExtentProtoType: background ?? toolbar,
        title: title,
        leading: leading,
        actions: actions,
        background: background,
        statusbarHeight: statusbarHeight,
        toolbarHeight: toolbarHeight,
        toolBarColor: toolBarColor,
        onBuild: onBuild,
        isOpacityFadeWithToolbar: isOpacityFadeWithToolbar,
        isOpacityFadeWithTitle: isOpacityFadeWithTitle,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        opacityShow: opacityShow,
      ),
    );
  }
}

class _ExtendedSliverAppbarDelegate extends SliverPinnedPersistentHeaderDelegate {
  _ExtendedSliverAppbarDelegate({
    required Widget minExtentProtoType,
    required Widget maxExtentProtoType,
    this.leading,
    this.title,
    this.actions,
    this.background,
    this.toolBarColor,
    this.onBuild,
    this.statusbarHeight,
    this.toolbarHeight,
    this.isOpacityFadeWithToolbar = true,
    this.isOpacityFadeWithTitle = true,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.opacityShow = 0,
  }) : super(
          minExtentProtoType: minExtentProtoType,
          maxExtentProtoType: maxExtentProtoType,
        );

  /// A widget to display before the [title].
  final Widget? leading;

  /// The primary widget displayed in the app bar.
  ///
  /// Typically a [Text] widget containing a description of the current contents
  /// of the app.
  final Widget? title;

  /// Widgets to display after the [title] widget.
  final Widget? actions;

  /// A Widget to display behind [leading],[title],[actions].
  final Widget? background;

  /// Background color for Row(leading,title,background).
  final Color? toolBarColor;

  /// Call when re-build on scroll.
  final OnSliverPinnedPersistentHeaderDelegateBuild? onBuild;

  /// Height of Toolbar. Default value : kToolbarHeight
  final double? toolbarHeight;

  /// Height of Statusbar. Default value : MediaQuery.of(context).padding.top
  final double? statusbarHeight;

  /// Whether do an opacity fade for toolbar.
  ///
  /// By default, the value of isOpacityFadeWithToolbar is true.
  final bool isOpacityFadeWithToolbar;

  /// Whether do an opacity fade for title.
  ///
  /// By default, the value of isOpacityFadeWithTitle is true.
  final bool isOpacityFadeWithTitle;

  /// MainAxisAlignment of toolbar
  ///
  /// By default, the value of mainAxisAlignment is MainAxisAlignment.spaceBetween.
  final MainAxisAlignment mainAxisAlignment;

  /// CrossAxisAlignment of toolbar
  ///
  /// By default, the value of crossAxisAlignment is CrossAxisAlignment.center.
  final CrossAxisAlignment crossAxisAlignment;

  /// author ch
  /// 控制内容展示时机，为1最终才展示，为0默认占用空间
  final double opacityShow;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    double? minExtent,
    double maxExtent,
    bool overlapsContent,
  ) {
    onBuild?.call(context, shrinkOffset, minExtent, maxExtent, overlapsContent);
    final double opacity = (shrinkOffset / (maxExtent - minExtent!)).clamp(0.0, 1.0);
    Widget? titleWidget = title;
    if (titleWidget != null) {
      if (isOpacityFadeWithTitle) {
        titleWidget = Opacity(
          opacity: opacity,
          child: titleWidget,
        );
      }
    } else {
      titleWidget = Container();
    }
    Widget? leadingWidget = leading;
    if (leadingWidget != null) {
      if (isOpacityFadeWithTitle) {
        leadingWidget = Opacity(
          opacity: opacity,
          child: leadingWidget,
        );
      }
    } else {
      leadingWidget = Container();
    }
    Widget? actionsWidget = actions;
    if (actionsWidget != null) {
      if (isOpacityFadeWithTitle) {
        actionsWidget = Opacity(
          opacity: opacity,
          child: actionsWidget,
        );
      }
    } else {
      actionsWidget = Container();
    }
    final ThemeData theme = Theme.of(context);

    Color toolBarColor = this.toolBarColor ?? theme.primaryColor;
    if (isOpacityFadeWithToolbar) {
      toolBarColor = toolBarColor.withOpacity(opacity);
    }

    final Widget toolbar = Container(
      height: toolbarHeight! + statusbarHeight!,
      padding: EdgeInsets.only(top: statusbarHeight!),
      color: toolBarColor,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: <Widget>[
          leadingWidget,
          titleWidget,
          actionsWidget,
        ],
      ),
    );

    return Visibility(
      visible: opacity >= opacityShow,
      child: Material(
        child: ClipRect(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: maxExtentProtoType,
                top: -shrinkOffset,
                bottom: 0,
                left: 0,
                right: 0,
              ),
              Positioned(
                child: toolbar,
                top: 0,
                left: 0,
                right: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPinnedPersistentHeaderDelegate oldDelegate) {
    if (oldDelegate.runtimeType != runtimeType) {
      return true;
    }

    return oldDelegate is _ExtendedSliverAppbarDelegate &&
        (oldDelegate.minExtentProtoType != minExtentProtoType ||
            oldDelegate.maxExtentProtoType != maxExtentProtoType ||
            oldDelegate.leading != leading ||
            oldDelegate.title != title ||
            oldDelegate.actions != actions ||
            oldDelegate.background != background ||
            oldDelegate.statusbarHeight != statusbarHeight ||
            oldDelegate.toolBarColor != toolBarColor ||
            oldDelegate.toolbarHeight != toolbarHeight ||
            oldDelegate.onBuild != onBuild ||
            oldDelegate.isOpacityFadeWithTitle != isOpacityFadeWithTitle ||
            oldDelegate.isOpacityFadeWithToolbar != isOpacityFadeWithToolbar ||
            oldDelegate.mainAxisAlignment != mainAxisAlignment ||
            oldDelegate.crossAxisAlignment != crossAxisAlignment);
  }
}

/// Call when re-build on scroll
typedef OnSliverPinnedPersistentHeaderDelegateBuild = void Function(
  BuildContext context,
  double shrinkOffset,
  double? minExtent,
  double maxExtent,
  bool overlapsContent,
);
