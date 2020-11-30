import 'package:flutter/material.dart';

///
/// Images must be of the extension specified in [_extension] and placed in [_path]
/// while following the following naming conventions:
/// [ASSET_NAME]_light_theme for light theme images and
/// [ASSET_NAME]_dark_theme for dark theme ones.
///
abstract class AppImages {
  static const String _path = 'assets/graphics/images/';
  static const String _extension = 'png';

  static AssetImage _getAssetForTheme(BuildContext context, {@required String assetName}) {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return AssetImage('$_path${assetName}_light_theme.$_extension');
      case Brightness.dark:
        return AssetImage('$_path${assetName}_dark_theme.$_extension');
    }
    throw UnsupportedError('${Theme.of(context).brightness} is not supported');
  }

  static AssetImage imdb(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_imdb',
      );

  static AssetImage tmdb(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_tmdb',
      );

  static AssetImage rottenCertified(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_rotten_certified',
      );

  static AssetImage rottenCriticPositive(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_rotten_critic_positive',
      );

  static AssetImage rottenCriticNegative(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_rotten_critic_negative',
      );

  static AssetImage rottenPublicPositive(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_rotten_public_positive',
      );

  static AssetImage rottenPublicNegative(BuildContext context) => _getAssetForTheme(
        context,
        assetName: 'image_rotten_public_negative',
      );
}
