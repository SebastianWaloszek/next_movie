import 'package:flutter/material.dart';
import 'package:next_movie/common/utils/extensions/widget_extensions.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class PersonCell extends StatelessWidget {
  static const double imageSize = 77;
  final String name;
  final String role;
  final String department;

  final String imageUrl;

  final EdgeInsets margin;

  bool get hasImage => imageUrl != null;

  bool get hasDepartment => department != null;

  const PersonCell({
    Key key,
    @required this.name,
    this.department,
    this.role,
    this.imageUrl,
    this.margin,
  })  : assert(name != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 110,
      child: Column(
        children: [
          if (hasDepartment) _buildDepartmentText(context), // TODO Refactor by creating new widget
          _buildImage(context),
          _buildNameText(context),
          _buildRoleText(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: cellShadow(context),
        color: AppColors.background(context),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: hasImage ? _buildNetworkImage() : _buildPlaceholderImage(context),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      imageUrl,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      color: const Color(0xFFDBDBDB),
      child: const Icon(
        Icons.person,
        size: 50,
        color: Color(0xFFB5B5B5),
      ),
    );
  }

  Widget _buildDepartmentText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        department,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.body1(context),
      ),
    );
  }

  Widget _buildNameText(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Text(
        name,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.headline4(context),
      ),
    );
  }

  Widget _buildRoleText(BuildContext context) {
    return Text(
      role,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.subtitle3(context),
    );
  }
}
