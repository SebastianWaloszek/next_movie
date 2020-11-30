import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NavigationBarTab extends Equatable {
  final IconData icon;
  final String title;
  final Widget page;

  const NavigationBarTab(
    this.icon, {
    this.title,
    @required this.page,
  })  : assert(icon != null || title != null),
        assert(page != null);

  @override
  List<Object> get props => [icon, title];
}
