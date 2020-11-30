import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class MovieDetailRow extends StatelessWidget {
  final String name;
  final TextStyle nameTextStyle;
  final EdgeInsets nameMargin;
  final Widget child;
  final EdgeInsets childMargin;
  final String sufix;
  final EdgeInsets sufixMargin;
  final void Function() onSufixTap;

  const MovieDetailRow({
    Key key,
    @required this.name,
    this.nameTextStyle,
    @required this.child,
    this.childMargin,
    this.nameMargin,
    this.sufix,
    this.sufixMargin,
    this.onSufixTap,
  })  : assert(name != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        _buildChild(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: nameMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildNameText(context),
          if (sufix != null) _buildSufixText(context),
        ],
      ),
    );
  }

  Widget _buildNameText(BuildContext context) {
    return Text(
      name,
      style: nameTextStyle ?? AppTextStyles.body1(context),
    );
  }

  Widget _buildSufixText(BuildContext context) {
    return Container(
      margin: sufixMargin,
      child: InkResponse(
        onTap: onSufixTap,
        child: Text(
          sufix,
          style: AppTextStyles.headline3(
            context,
            color: AppColors.secondaryContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return Container(
      margin: childMargin ?? const EdgeInsets.only(top: 10),
      child: child,
    );
  }
}
