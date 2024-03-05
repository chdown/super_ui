import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ImageType { asset, network, file }

/// @author : ch
/// @description 图片加载
///
class SuperImage extends StatelessWidget {
  /// 图片路径
  final String url;

  /// 占位图
  final Widget? placeholder;

  /// 错误图
  final Widget? error;

  /// 图片类型
  final ImageType? type;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 圆角
  final double? radius;

  /// 适应方式
  final BoxFit fit;

  /// 背景
  final Color? backgroundColor;

  /// 模式
  final ExtendedImageMode mode;

  /// 是否超出page
  final bool enableSlideOutPage;

  /// 触摸配置
  final InitGestureConfigHandler? initGestureConfig;

  final Widget Function(
    BuildContext context,
    ImageProvider provider,
    Widget completed,
    Size? size,
  )? builder;

  const SuperImage({
    Key? key,
    required this.url,
    this.type,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.builder,
    this.mode = ExtendedImageMode.none,
    this.enableSlideOutPage = false,
    this.initGestureConfig,
    this.backgroundColor,
    this.placeholder,
    this.error,
  }) : super(key: key);

  const SuperImage.network({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = ImageType.network,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  const SuperImage.asset({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = ImageType.asset,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  const SuperImage.file({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit = BoxFit.cover,
    this.backgroundColor,
    this.placeholder,
    this.error,
    this.builder,
  })  : type = ImageType.file,
        mode = ExtendedImageMode.none,
        enableSlideOutPage = false,
        initGestureConfig = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.all(Radius.circular(radius ?? 10));
    final Widget errorChild = error ?? const Icon(Icons.image_not_supported_outlined);
    final Widget placeholderChild = placeholder ?? const CupertinoActivityIndicator(radius: 12);
    ImageType? superImageType = type;
    if (superImageType == null) {
      if (url.startsWith("assets")) superImageType = ImageType.asset;
      if (url.startsWith("http")) superImageType = ImageType.network;
      if (url.startsWith("/")) superImageType = ImageType.file;
    }
    Widget? image;
    switch (superImageType!) {
      case ImageType.asset:
        if (!url.startsWith('assets/')) {
          image = errorChild;
        } else {
          image = ExtendedImage.asset(
            url,
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            gaplessPlayback: true,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
      case ImageType.network:
        if (!url.startsWith('http')) {
          image = errorChild;
        } else {
          image = ExtendedImage.network(
            url,
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            gaplessPlayback: true,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
      case ImageType.file:
        if (!url.startsWith('/')) {
          image = errorChild;
        } else {
          image = ExtendedImage.file(
            File(url),
            key: ValueKey(url),
            width: width,
            height: height,
            fit: fit,
            shape: BoxShape.rectangle,
            borderRadius: borderRadius,
            mode: mode,
            gaplessPlayback: true,
            enableSlideOutPage: enableSlideOutPage,
            initGestureConfigHandler: initGestureConfig,
            loadStateChanged: (state) => _buildLoadState(
              context: context,
              state: state,
              placeholder: placeholderChild,
              error: errorChild,
            ),
          );
        }
        break;
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      width: width,
      height: height,
      decoration: BoxDecoration(
        // todo Color(0xFFF3F4F6)  Color(0xFF141414)
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: 24,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
        child: image,
      ),
    );
  }

  Widget _buildLoadState({
    required BuildContext context,
    required ExtendedImageState state,
    required Widget placeholder,
    required Widget error,
  }) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        return Center(child: placeholder);
      case LoadState.completed:
        Size? size;
        if (state.extendedImageInfo != null) {
          size = Size(
            state.extendedImageInfo!.image.width.toDouble(),
            state.extendedImageInfo!.image.height.toDouble(),
          );
        }
        final provider = state.imageProvider;
        final completed = state.completedWidget;
        return builder?.call(context, provider, completed, size) ?? completed;
      case LoadState.failed:
        return Center(child: error);
    }
  }
}
