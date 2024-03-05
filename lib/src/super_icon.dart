import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_svg/flutter_svg.dart';

enum IconType { icon, svg, image, url }

/// @author : ch
/// @description 图标组件
///
class SuperIcon extends StatelessWidget {
  /// 图标类型
  final IconType? type;

  /// 图标数据
  final IconData? iconData;

  /// assets 路径
  final String? assetName;

  /// 图片 url
  final String? imageUrl;

  /// 尺寸
  final double? size;

  /// 宽
  final double? width;

  /// 高
  final double? height;

  /// 颜色
  final Color? color;

  /// 图片 fit
  final BoxFit? fit;

  const SuperIcon({
    Key? key,
    this.type = IconType.icon,
    this.size,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.assetName,
    this.imageUrl,
    this.fit,
  }) : super(key: key);

  SuperIcon.icon(
    this.iconData, {
    Key? key,
    this.type = IconType.icon,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.assetName,
    this.imageUrl,
    this.fit,
  }) : super(key: key) {
    return;
  }

  SuperIcon.image(
    this.assetName, {
    Key? key,
    this.type = IconType.image,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.imageUrl,
    this.fit,
  }) : super(key: key) {
    return;
  }

  SuperIcon.svg(
    this.assetName, {
    Key? key,
    this.type = IconType.svg,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.imageUrl,
    this.fit,
  }) : super(key: key) {
    return;
  }

  SuperIcon.url(
    this.imageUrl, {
    Key? key,
    this.type = IconType.url,
    this.size = 24,
    this.width,
    this.height,
    this.color,
    this.iconData,
    this.assetName,
    this.fit,
  }) : super(key: key) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    switch (type) {
      case IconType.icon:
        icon = Icon(
          iconData,
          size: size,
          color: color,
        );
        break;
      case IconType.svg:
        icon = SvgPicture.asset(
          assetName!,
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      case IconType.image:
        icon = Image.asset(
          assetName!,
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      case IconType.url:
        icon = Image.network(
          imageUrl!,
          width: width ?? size,
          height: height ?? size,
          color: color,
          fit: fit ?? BoxFit.contain,
        );
        break;
      default:
        return const SizedBox();
    }
    return icon;
  }
}
