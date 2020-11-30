import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/home/widgets/bottom_app_navigation_bar.dart';
import 'package:next_movie/presentation/features/home/widgets/navigation_bar_tab.dart';
import 'package:next_movie/presentation/features/home/widgets/side_app_navigation_bar.dart';
import 'package:next_movie/presentation/features/movie_list/pages/movie_list_page.dart';
import 'package:next_movie/presentation/localization/app_localizations.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  static const double bottomBarHeight = 70;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<NavigationBarTab> getTabs(BuildContext context) => [
        NavigationBarTab(
          Icons.movie,
          title: AppLocalizations.of(context).movies(),
          page: const MovieListPage(),
        ),
        NavigationBarTab(
          Icons.tv,
          title: AppLocalizations.of(context).tv(),
          page: const Scaffold(),
        ),
        NavigationBarTab(
          Icons.settings,
          title: AppLocalizations.of(context).settings(),
          page: const Scaffold(),
        )
      ];

  void onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        return _buildHome(isLandscape);
      },
    );
  }

  Widget _buildHome(bool isLandscape) {
    return Scaffold(
      backgroundColor: AppColors.navigationBar(context),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            if (isLandscape) _buildSideNavigationBar(context),
            Expanded(child: getTabs(context)[_currentIndex].page),
          ],
        ),
      ),
      bottomNavigationBar: isLandscape ? null : _buildBottomNavigationBar(context),
    );
  }

  SideAppNavigationBar _buildSideNavigationBar(BuildContext context) {
    return SideAppNavigationBar(
      initialIndex: 0,
      onTabSelected: onTabSelected,
      tabs: getTabs(context),
    );
  }

  BottomAppNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomAppNavigationBar(
      currentIndex: _currentIndex,
      onTabSelected: onTabSelected,
      tabs: getTabs(context),
    );
  }
}
