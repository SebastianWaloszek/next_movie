import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/home/pages/home_page.dart';
import 'package:next_movie/presentation/features/home/widgets/navigation_bar_tab.dart';
import 'package:next_movie/presentation/theme/app_text_styles.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';
import 'package:meta/meta.dart';

class BottomAppNavigationBar extends StatelessWidget {
  final List<NavigationBarTab> tabs;
  final void Function(int) onTabSelected;
  final int currentIndex;

  const BottomAppNavigationBar({
    Key key,
    @required this.tabs,
    @required this.onTabSelected,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: _buildBottomBarDecoration(context),
        height: HomePage.bottomBarHeight,
        child: BottomNavigationBar(
          iconSize: 26,
          elevation: 0,
          currentIndex: currentIndex,
          items: tabs.map((tab) => _buildBottomNavigationBarItem(icon: tab.icon, title: tab.title)).toList(),
          backgroundColor: AppColors.navigationBar(context),
          unselectedItemColor: AppColors.secondaryContent(context),
          selectedItemColor: AppColors.secondaryAccent(context),
          onTap: onTabSelected,
          unselectedLabelStyle: AppTextStyles.bottomBar(context),
          selectedLabelStyle: AppTextStyles.bottomBar(context, color: AppColors.secondaryAccent(context)),
        ),
      ),
    );
  }

  BoxDecoration _buildBottomBarDecoration(BuildContext context) {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColors.shadow(context),
          blurRadius: 4,
          spreadRadius: -3,
          offset: const Offset(0, -3),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {@required IconData icon, @required String title}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Icon(icon),
      ),
      label: title,
    );
  }
}
