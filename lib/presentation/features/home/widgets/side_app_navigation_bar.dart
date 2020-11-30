import 'package:flutter/material.dart';
import 'package:next_movie/presentation/features/home/widgets/navigation_bar_tab.dart';
import 'package:next_movie/presentation/theme/color/app_colors.dart';

class SideAppNavigationBar extends StatefulWidget {
  final List<NavigationBarTab> tabs;
  final void Function(int) onTabSelected;
  final int initialIndex;

  const SideAppNavigationBar({
    Key key,
    @required this.tabs,
    @required this.onTabSelected,
    @required this.initialIndex,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SideAppNavigationBarState createState() => _SideAppNavigationBarState(initialIndex);
}

class _SideAppNavigationBarState extends State<SideAppNavigationBar> with SingleTickerProviderStateMixin {
  final int initialIndex;
  TabController _tabController;

  _SideAppNavigationBarState(this.initialIndex);

  @override
  void initState() {
    _initTabController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _initTabController() {
    _tabController = TabController(
      initialIndex: initialIndex,
      length: widget.tabs.length,
      vsync: this,
    );
    _tabController.addListener(() {
      widget.onTabSelected(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Stack(
        children: <Widget>[
          _buildShadow(context),
          Ink(
            color: AppColors.navigationBar(context),
            child: TabBar(
              controller: _tabController,
              tabs: widget.tabs.map((tabItem) => _buildTabItem(tabItem)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShadow(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow(context),
            blurRadius: 4,
            spreadRadius: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(NavigationBarTab tab) {
    return RotatedBox(
      quarterTurns: -1,
      child: SizedBox(
        width: 100,
        child: Tab(
          child: Column(
            children: [
              Icon(tab.icon, color: AppColors.primaryContent(context)),
              _buildTabItemTitle(tab),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItemTitle(NavigationBarTab tab) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        tab.title,
        style: TextStyle(color: AppColors.primaryContent(context)),
      ),
    );
  }
}
