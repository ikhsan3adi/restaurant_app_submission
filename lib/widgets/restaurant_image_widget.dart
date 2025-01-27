import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/enum/image_size.dart';

class RestaurantImageWidget extends StatelessWidget {
  const RestaurantImageWidget.small({
    super.key,
    required this.pictureId,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.iconSize = _defaultIconSize,
    this.fadeInDuration = const Duration(milliseconds: 500),
  }) : imageSize = ImageSize.small;

  const RestaurantImageWidget.medium({
    super.key,
    required this.pictureId,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.iconSize = _defaultIconSize,
    this.fadeInDuration = const Duration(milliseconds: 500),
  }) : imageSize = ImageSize.medium;

  const RestaurantImageWidget.large({
    super.key,
    required this.pictureId,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.iconSize = _defaultIconSize,
    this.fadeInDuration = const Duration(milliseconds: 500),
  }) : imageSize = ImageSize.large;

  final String pictureId;
  final ImageSize imageSize;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  static const double _defaultIconSize = 56;
  final double iconSize;
  final Duration fadeInDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CachedNetworkImage(
      imageUrl: ApiServices.restaurantImageUrl(
        pictureId,
        imageSize,
      ),
      fit: fit,
      width: width,
      height: height,
      fadeInDuration: fadeInDuration,
      placeholder: (_, __) =>
          placeholder ??
          Container(
            color: theme.colorScheme.surfaceContainerLow,
            width: width,
            height: height,
          ),
      errorWidget: errorWidget ??
          (_, __, ___) => Container(
                color: theme.colorScheme.errorContainer,
                width: width,
                height: height,
                child: Icon(
                  Icons.broken_image_outlined,
                  size: iconSize,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
    );
  }
}
