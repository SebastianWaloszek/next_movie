import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_theme_constants.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

import 'ignore_pointer_opacity.dart';

// ignore_for_file: return_of_invalid_type, argument_type_not_assignable
class ExpandableTopBar extends StatelessWidget {
  /// Scroll distance needed to reach to make the expanded section completely transparent
  /// and start showing the collapsed section. Collapsed section will be fully visible when
  /// [scrollOffset] >= 2 * [expandedThreshold]
  static const double expandedThreshold = 30;

  /// Size of [leading] and [trailing] containers.
  static const double _sideItemSize = 34;

  /// Specify [expandedTitle]  if you want to display a title widget when top bar is expanded.
  final Widget expandedTitle;

  /// Specify [collapsedTitle] if you want to display a title widget when top bar is collapsed.
  final Widget collapsedTitle;

  /// Will always be displayed in the collapsed row,
  /// above [expandedTitle] or to the left of [collapsedTitle].
  final Widget leading;

  /// Will be displayed on the right side of the top bar,
  /// to the right of [expandedTitle] when expanded
  /// and to the right of [collapsedTitle] when collapsed
  final Widget trailing;

  /// Will be displayed at the bottom ot the top bar.
  final Widget bottom;

  /// Will be applied to [expandedTitle] and [trailing] in expanded row.
  final EdgeInsets expandedContentPadding;

  /// Specify [collapsedBottom] if you want to use different bottom widget when the top bar is collapsed.
  /// Can only be specified if [bottom] is not null.
  final Widget collapsedBottom;

  /// Height of the top bar when expanded. Must not be null.
  final double height;

  /// Specify [collapsedHeight] to make the top bar shrinkable.
  final double collapsedHeight;

  /// Adds a shadow below the top bar.
  final bool elevated;

  /// Adds a shadow below the top bar when [scrollOffset] is greater than 0.
  final bool elevateOnScroll;

  /// Scrollview offset. Must not be null.
  final double scrollOffset;

  /// Top bar background color.
  final Color color;

  bool get collapses => collapsedHeight != height;

  bool get _scrolled => scrollOffset > 0;

  double get _collapsedOpacity => collapses ? ((scrollOffset - expandedThreshold) / expandedThreshold).clamp(0.0, 1.0).toDouble() : 0.0;

  double get _expandedOpacity => collapses ? ((expandedThreshold - scrollOffset) / expandedThreshold).clamp(0.0, 1.0).toDouble() : 1.0;

  const ExpandableTopBar({
    Key key,
    this.expandedTitle,
    this.collapsedTitle,
    this.leading,
    this.trailing,
    this.bottom,
    this.expandedContentPadding,
    this.collapsedBottom,
    @required this.height,
    double collapsedHeight,
    this.elevated = true,
    this.elevateOnScroll = false,
    @required this.scrollOffset,
    this.color,
  })  : assert(height != null),
        assert(scrollOffset != null),
        assert(
          bottom != null || collapsedBottom == null,
          'Collapsed bottom can only be specified if bottom is also specified',
        ),
        collapsedHeight = collapsedHeight ?? height,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildShadowContainer(context),
        _buildTopBar(context),
      ],
    );
  }

  Widget _buildShadowContainer(BuildContext context) {
    return Ink(
      width: double.infinity,
      height: 5,
      decoration: _buildDecoration(context),
    );
  }

  BoxDecoration _buildDecoration(BuildContext context) {
    final shouldAddShadow = elevated || (elevateOnScroll && _scrolled);
    return BoxDecoration(
      color: color ?? AppColors.navigationBar(context),
      boxShadow: [
        if (shouldAddShadow)
          BoxShadow(
            color: AppColors.shadow(context),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
      ],
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Ink(
      color: color ?? AppColors.navigationBar(context),
      height: (height - scrollOffset).clamp(collapsedHeight, height).toDouble(),
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          _buildContentStack(),
          if (bottom != null) _buildBottom(),
        ],
      ),
    );
  }

  Widget _buildContentStack() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppThemeConstants.horizontal),
      child: Stack(
        children: <Widget>[
          _buildExpandedRow(),
          _buildCollapsedRow(),
        ],
      ),
    );
  }

  Widget _buildCollapsedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildLeading(opacity: _collapsedOpacity),
        if (collapsedTitle != null) _buildCollapsedTitle(),
        _buildTrailing(opacity: _collapsedOpacity),
      ],
    );
  }

  Widget _buildLeading({@required double opacity, Offset offset}) {
    return _buildSideItem(
      child: leading,
      opacity: opacity,
      offset: offset,
    );
  }

  Widget _buildTrailing({@required double opacity, Offset offset}) {
    return _buildSideItem(
      child: trailing,
      opacity: opacity,
      offset: offset,
    );
  }

  Widget _buildSideItem({
    @required Widget child,
    @required double opacity,
    Offset offset,
  }) {
    return IgnorePointerOpacity(
      opacity: opacity,
      child: Transform.translate(
        offset: offset ?? Offset.zero,
        child: SizedBox(
          width: _sideItemSize,
          height: _sideItemSize,
          child: child,
        ),
      ),
    );
  }

  Widget _buildCollapsedTitle() {
    return Flexible(
      child: Opacity(
        opacity: _collapsedOpacity,
        child: collapsedTitle,
      ),
    );
  }

  Widget _buildExpandedRow() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: expandedContentPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (leading != null)
              _buildLeading(
                opacity: _expandedOpacity,
                offset: const Offset(0, -16),
              ),
            _buildExpandedTitle(),
            if (trailing != null)
              _buildTrailing(
                opacity: _expandedOpacity,
                offset: const Offset(0, 8),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedTitle() {
    return Expanded(
      child: Opacity(
        opacity: _expandedOpacity,
        child: expandedTitle,
      ),
    );
  }

  Widget _buildBottom() {
    final hasTwoBottoms = bottom != null && collapsedBottom != null;
    if (hasTwoBottoms) {
      return Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          _buildCollapsedBottom(),
          _buildExpandedBottom(),
        ],
      );
    }
    return Align(
      alignment: Alignment.bottomLeft,
      child: bottom,
    );
  }

  Widget _buildCollapsedBottom() {
    return IgnorePointerOpacity(
      opacity: _collapsedOpacity,
      child: collapsedBottom ?? bottom,
    );
  }

  Widget _buildExpandedBottom() {
    return IgnorePointerOpacity(
      opacity: _expandedOpacity,
      child: bottom,
    );
  }
}
