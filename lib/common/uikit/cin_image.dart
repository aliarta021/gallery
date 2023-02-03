import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:revolution1401/common/constants/app_config.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette.dart';
import 'package:revolution1401/common/styles/colorPalette/color_palette_helper.dart';
import 'package:revolution1401/common/uikit/nullable_hero.dart';
import 'package:revolution1401/common/uikit/shimmer_container.dart';
import 'package:revolution1401/common/utils/locale_helper.dart';

class CinImage extends StatefulWidget {
  const CinImage(
    this.imageUrl, {
    Key? key,
    this.httpHeaders,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.fadeOutCurve = Curves.easeOut,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeInCurve = Curves.easeIn,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.filterQuality = FilterQuality.low,
    this.colorBlendMode,
    this.placeholderFadeInDuration,
    this.memCacheWidth,
    this.memCacheHeight,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.blurHash,
    this.autoDownload = true,
    this.heroTag,
  }) : super(key: key);

  factory CinImage.fromHashKey(
    String? hashKey, {
    int? imageQuality,
    int? imageWidth,
    int? imageHeight,
    String? cacheKey,
    Key? key,
    ImageWidgetBuilder? imageBuilder,
    PlaceholderWidgetBuilder? placeholder,
    ProgressIndicatorBuilder? progressIndicatorBuilder,
    LoadingErrorWidgetBuilder? errorWidget,
    Duration? placeholderFadeInDuration,
    Duration fadeOutDuration = const Duration(milliseconds: 1000),
    Curve fadeOutCurve = Curves.easeOut,
    Duration fadeInDuration = const Duration(milliseconds: 500),
    Curve fadeInCurve = Curves.easeIn,
    double? width,
    double? height,
    BoxFit? fit = BoxFit.cover,
    Alignment alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    bool useOldImageOnUrlChange = false,
    Color? color,
    BlendMode? colorBlendMode,
    FilterQuality filterQuality = FilterQuality.low,
    int? memCacheWidth,
    int? memCacheHeight,
    int? maxWidthDiskCache,
    int? maxHeightDiskCache,
    bool autoDownload = true,
    String? blurHash,
    String? Function(String? hashKey)? heroTag,
  }) =>
      CinImage(
        CinImage.getImageUrl(
            hashKey: hashKey,
            quality: imageQuality,
            width: imageWidth,
            height: imageHeight),
        heroTag: heroTag == null ? null : heroTag(hashKey),
        key: key,
        // httpHeaders: {
        //   'Authorization': 'Bearer ${AuthBloc().accessToken}',
        // },
        imageBuilder: imageBuilder,
        placeholder: placeholder,
        progressIndicatorBuilder: progressIndicatorBuilder,
        errorWidget: errorWidget,
        fadeOutDuration: fadeOutDuration,
        fadeOutCurve: fadeOutCurve,
        fadeInDuration: fadeInDuration,
        fadeInCurve: fadeInCurve,
        width: width,
        blurHash: blurHash,
        autoDownload: autoDownload,
        height: height,
        fit: fit,
        alignment: alignment,
        repeat: repeat,
        matchTextDirection: matchTextDirection,
        useOldImageOnUrlChange: useOldImageOnUrlChange,
        color: color,
        filterQuality: filterQuality,
        colorBlendMode: colorBlendMode,
        placeholderFadeInDuration: placeholderFadeInDuration,
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        cacheKey: cacheKey,
        maxWidthDiskCache: maxWidthDiskCache,
        maxHeightDiskCache: maxHeightDiskCache,
      );

  final String imageUrl;
  final String? cacheKey;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final Duration? placeholderFadeInDuration;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Map<String, String>? httpHeaders;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final bool autoDownload;
  final String? blurHash;
  final String? heroTag;

  static ImageProvider? providerFromHashKey(String hashKey) => hashKey.isEmpty
      ? null
      : CachedNetworkImageProvider(
          CinImage.getImageUrl(hashKey: hashKey),
          // headers: {
          //   'Authorization': 'Bearer ${AuthBloc().accessToken}',
          // },
        );

  static String getImageUrl(
          {required String? hashKey, int? quality, int? width, int? height}) =>
      hashKey == null
          ? ''
          : '${AppConfig.localePath}file?hashKey=$hashKey${width == null ? '' : '&width=$width'}${height == null ? '' : '&height=$height'}${quality == null ? '' : '&quality=$quality'}';

  @override
  State<CinImage> createState() => _CinImageState();
}

class _CinImageState extends State<CinImage> {
  bool? autoDownload;

  @override
  void initState() {
    super.initState();
    autoDownload = widget.autoDownload;
  }

  Widget _defaultProgressIndicatorBuilder(
          BuildContext context, String url, DownloadProgress progress) =>
      Stack(
        alignment: Alignment.center,
        children: [
          BlurHash(
            hash: widget.blurHash ?? '000000',
            imageFit: widget.fit ?? BoxFit.cover,
          ),
          CircularPercentIndicator(
            radius: 150,
            percent: progress.progress ?? 0,
            center: Text(
              '${(progress.progress ?? 0) * 100}}%',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            backgroundColor: Colors.transparent,
            progressColor: ColorPalette.of(context).scaffoldBackground,
          )
        ],
      );

  Widget _defaultErrorWidget(BuildContext context, String url, err) =>
      Container(
        color: context.colors.black.withOpacity(0.015),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: FittedBox(
            child: SvgPicture.asset(context.localeLogoType,
                color: context.colors.black.withOpacity(0.1)),
          ),
        ),
      );

  Widget _defaultPlaceholder(context, url) => const ShimmerContainer();

  @override
  Widget build(BuildContext context) => NullableHero(
      tag: widget.heroTag,
      child: widget.imageUrl.isEmpty
          ? _defaultErrorWidget(context, '', '')
          : CachedNetworkImage(
              imageUrl: widget.imageUrl,
              httpHeaders: widget.httpHeaders,
              imageBuilder: widget.imageBuilder,
              placeholder: widget.placeholder ?? _defaultPlaceholder,
              errorWidget: widget.errorWidget ?? _defaultErrorWidget,
              progressIndicatorBuilder: widget.progressIndicatorBuilder ??
                  (widget.blurHash == null
                      ? null
                      : _defaultProgressIndicatorBuilder),
              fadeOutDuration: widget.fadeOutDuration,
              fadeOutCurve: widget.fadeOutCurve,
              fadeInDuration: widget.fadeInDuration,
              fadeInCurve: widget.fadeInCurve,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              alignment: widget.alignment,
              repeat: widget.repeat,
              matchTextDirection: widget.matchTextDirection,
              useOldImageOnUrlChange: widget.useOldImageOnUrlChange,
              color: widget.color,
              filterQuality: widget.filterQuality,
              colorBlendMode: widget.colorBlendMode,
              placeholderFadeInDuration: widget.placeholderFadeInDuration,
              memCacheWidth: widget.memCacheWidth,
              memCacheHeight: widget.memCacheHeight,
              cacheKey: widget.cacheKey,
              maxWidthDiskCache: widget.maxWidthDiskCache,
              maxHeightDiskCache: widget.maxHeightDiskCache,
            )
      //    Builder(
      // builder: (context) {
      // return CachedNetworkImage(
      //   imageUrl: widget.imageUrl,
      //   httpHeaders: widget.httpHeaders,
      //   imageBuilder: widget.imageBuilder,
      //   placeholder: widget.placeholder ?? _defaultPlaceholder,
      //   errorWidget: widget.errorWidget ?? _defaultErrorWidget,
      //   progressIndicatorBuilder: widget.progressIndicatorBuilder ??
      //       (widget.blurHash == null
      //           ? null
      //           : _defaultProgressIndicatorBuilder),
      //   fadeOutDuration: widget.fadeOutDuration,
      //   fadeOutCurve: widget.fadeOutCurve,
      //   fadeInDuration: widget.fadeInDuration,
      //   fadeInCurve: widget.fadeInCurve,
      //   width: widget.width,
      //   height: widget.height,
      //   fit: widget.fit,
      //   alignment: widget.alignment,
      //   repeat: widget.repeat,
      //   matchTextDirection: widget.matchTextDirection,
      //   useOldImageOnUrlChange: widget.useOldImageOnUrlChange,
      //   color: widget.color,
      //   filterQuality: widget.filterQuality,
      //   colorBlendMode: widget.colorBlendMode,
      //   placeholderFadeInDuration: widget.placeholderFadeInDuration,
      //   memCacheWidth: widget.memCacheWidth,
      //   memCacheHeight: widget.memCacheHeight,
      //   cacheKey: widget.cacheKey,
      //   maxWidthDiskCache: widget.maxWidthDiskCache,
      //   maxHeightDiskCache: widget.maxHeightDiskCache,
      // );
      // return autoDownload ?? false
      //     ? image
      //     : FutureBuilder<FileInfo?>(
      //         future:
      //             DefaultCacheManager().getFileFromCache(widget.imageUrl),
      //         builder: (context, snapshot) =>
      //             snapshot.hasData && snapshot.data?.file != null
      //                 ? image
      //                 : Stack(
      //                     alignment: Alignment.center,
      //                     children: [
      //                       BlurHash(
      //                         hash: widget.blurHash ?? '000000',
      //                         imageFit: widget.fit ?? BoxFit.cover,
      //                       ),
      //                       IconButton(
      //                         onPressed: () {
      //                           setState(() {
      //                             autoDownload = true;
      //                           });
      //                         },
      //                         icon: const Icon(Icons.download_rounded),
      //                       )
      //                     ],
      //                   ),
      //       );
      // },
      // ),
      );
}
