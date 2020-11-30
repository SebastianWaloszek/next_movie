import 'package:flutter/material.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

enum ButtonStyle { filled, border }

class Button extends StatelessWidget {
  final String title;
  final Widget leading;
  final ButtonStyle style;

  final void Function() onPressed;

  const Button(
    this.title, {
    this.leading,
    this.onPressed,
    this.style = ButtonStyle.filled,
    Key key,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: _getButtonColor(context),
      shape: _getButtonShape(context),
      child: Container(
        decoration: style == ButtonStyle.filled ? _buildButtonShadow(context) : null,
        child: _buildButtonContent(context),
      ),
    );
  }

  RoundedRectangleBorder _getButtonShape(BuildContext context) {
    switch (style) {
      case ButtonStyle.filled:
        return RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));
      case ButtonStyle.border:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: AppColors.primaryAccent(context)),
        );
    }
    throw UnsupportedError('Style $style is not supported');
  }

  Color _getButtonColor(BuildContext context) {
    switch (style) {
      case ButtonStyle.filled:
        return AppColors.primaryAccent(context);
      case ButtonStyle.border:
        return AppColors.background(context);
    }
    throw UnsupportedError('Style $style is not supported');
  }

  Widget _buildButtonContent(BuildContext context) {
    final bool hasIcon = leading != null;
    final double margin = hasIcon ? 10 : 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (leading != null) leading,
        _buildText(context, leftMargin: margin),
      ],
    );
  }

  Widget _buildText(BuildContext context, {double leftMargin = 0}) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin),
      child: Text(
        title,
        style: AppTextStyles.button1(context, color: _getTextColor(context)),
      ),
    );
  }

  Color _getTextColor(BuildContext context) {
    switch (style) {
      case ButtonStyle.filled:
        return AppColors.buttonContent(context);
      case ButtonStyle.border:
        return AppColors.primaryAccent(context);
    }
    throw UnsupportedError('Style $style is not supported');
  }

  BoxDecoration _buildButtonShadow(BuildContext context) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColors.primaryAccent(context).withOpacity(0.25),
          blurRadius: 30,
          offset: const Offset(0, 2),
        )
      ],
    );
  }
}
