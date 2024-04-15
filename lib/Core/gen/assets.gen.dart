/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/about.png
  AssetGenImage get about => const AssetGenImage('assets/images/about.png');

  /// File path: assets/images/araghi.png
  AssetGenImage get araghi => const AssetGenImage('assets/images/araghi.png');

  /// File path: assets/images/iraq-palm icon.png
  AssetGenImage get iraqPalmIcon =>
      const AssetGenImage('assets/images/iraq-palm icon.png');

  /// File path: assets/images/logo_tx 2.png
  AssetGenImage get logoTx2 =>
      const AssetGenImage('assets/images/logo_tx 2.png');

  /// File path: assets/images/main-logo.png
  AssetGenImage get mainLogo =>
      const AssetGenImage('assets/images/main-logo.png');

  /// File path: assets/images/menu.png
  AssetGenImage get menu => const AssetGenImage('assets/images/menu.png');

  /// File path: assets/images/nnews.png
  AssetGenImage get nnews => const AssetGenImage('assets/images/nnews.png');

  /// File path: assets/images/save-1.png
  AssetGenImage get save1 => const AssetGenImage('assets/images/save-1.png');

  /// File path: assets/images/save.png
  AssetGenImage get save => const AssetGenImage('assets/images/save.png');

  /// File path: assets/images/saves.png
  AssetGenImage get saves => const AssetGenImage('assets/images/saves.png');

  /// File path: assets/images/search.png
  AssetGenImage get search => const AssetGenImage('assets/images/search.png');

  /// File path: assets/images/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/settings.png');

  /// File path: assets/images/share.png
  AssetGenImage get share => const AssetGenImage('assets/images/share.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        about,
        araghi,
        iraqPalmIcon,
        logoTx2,
        mainLogo,
        menu,
        nnews,
        save1,
        save,
        saves,
        search,
        settings,
        share
      ];
}

class $AssetsVideosGen {
  const $AssetsVideosGen();

  /// File path: assets/videos/splash.mp4
  String get splash => 'assets/videos/splash.mp4';

  /// List of all assets
  List<String> get values => [splash];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsVideosGen videos = $AssetsVideosGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
