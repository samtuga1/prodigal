import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:prodigal/widgets/app_loader.dart';

class CustomCacheImage extends StatefulWidget {
  const CustomCacheImage(
    this.imageUrl, {
    super.key,
    this.height = 90,
    this.width = 90,
    this.loadingDimension = 93,
    this.fit = BoxFit.cover,
    this.loaderStrokeWidth,
    this.progressIndicatorBuilder,
  });
  final String imageUrl;
  final double height;
  final double width;
  final double loadingDimension;
  final BoxFit fit;
  final double? loaderStrokeWidth;
  final Widget Function(BuildContext, String, DownloadProgress)? progressIndicatorBuilder;

  @override
  State<CustomCacheImage> createState() => _CustomCacheImageState();
}

class _CustomCacheImageState extends State<CustomCacheImage> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      memCacheWidth: widget.width.round(),
      memCacheHeight: widget.height.round(),
      height: widget.height,
      width: widget.width,
      fit: widget.fit,
      imageUrl: widget.imageUrl,
      progressIndicatorBuilder: widget.progressIndicatorBuilder != null
          ? widget.progressIndicatorBuilder!
          : (ctx, url, downloadProgress) => AppLoader(value: downloadProgress.progress),
      errorWidget: (context, url, error) {
        print(error.toString());
        return Text(error.toString());
      },
    );
  }
}
