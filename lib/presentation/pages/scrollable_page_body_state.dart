import 'package:flutter/material.dart';

abstract class ScrollablePageBodyState<T extends StatefulWidget> extends State<T> {
  ScrollController scrollController = ScrollController();
  double scrollOffset = 0;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      scrollOffset = scrollController.offset;
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    scrollController.removeListener(_onScroll);
    super.dispose();
  }
}
