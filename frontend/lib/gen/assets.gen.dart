/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/.gitkeep
  String get gitkeep => 'assets/icons/.gitkeep';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/LOGO.png
  AssetGenImage get logo => const AssetGenImage('assets/images/LOGO.png');

  /// File path: assets/images/business.png
  AssetGenImage get business =>
      const AssetGenImage('assets/images/business.png');

  /// File path: assets/images/counsellor_profile_image.jpeg
  AssetGenImage get counsellorProfileImage =>
      const AssetGenImage('assets/images/counsellor_profile_image.jpeg');

  /// File path: assets/images/education.png
  AssetGenImage get education =>
      const AssetGenImage('assets/images/education.png');

  /// File path: assets/images/i.png
  AssetGenImage get i => const AssetGenImage('assets/images/i.png');

  /// File path: assets/images/marriage.png
  AssetGenImage get marriage =>
      const AssetGenImage('assets/images/marriage.png');

  /// File path: assets/images/medicinal.png
  AssetGenImage get medicinal =>
      const AssetGenImage('assets/images/medicinal.png');

  /// File path: assets/images/person.jpg
  AssetGenImage get person => const AssetGenImage('assets/images/person.jpg');

  /// File path: assets/images/plants.png
  AssetGenImage get plants => const AssetGenImage('assets/images/plants.png');

  /// File path: assets/images/userlist.png
  AssetGenImage get userlist =>
      const AssetGenImage('assets/images/userlist.png');

  /// File path: assets/images/yoga.png
  AssetGenImage get yoga => const AssetGenImage('assets/images/yoga.png');
}

class $AssetsLangsGen {
  const $AssetsLangsGen();

  /// File path: assets/langs/.gitkeep
  String get gitkeep => 'assets/langs/.gitkeep';
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLangsGen langs = $AssetsLangsGen();
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
    double? scale = 1.0,
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

  String get path => _assetName;
}
