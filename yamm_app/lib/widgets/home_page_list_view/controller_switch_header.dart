import 'package:expandable_sliver_list/expandable_sliver_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void _toggleController(
    ExpandableSliverListController controller, StateSetter setState) {
  if (controller.isCollapsed()) {
    controller.expand();
  } else {
    controller.collapse();
  }
  WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
}

Widget controllerSwitchHeader(ExpandableSliverListController controller,
    String titleVar, StateSetter setState,
    {String subtitleVar = ""}) {
  return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: ControllerSwitchHeaderDelegate(
          minExtent: 10,
          maxExtent: 40,
          stateSetter: setState,
          title: titleVar,
          switchVal: controller.isCollapsed(),
          controller: controller));
}

class ControllerSwitchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final StateSetter stateSetter;
  final String title;
  final bool switchVal;
  final ExpandableSliverListController controller;

  ControllerSwitchHeaderDelegate(
      {required this.minExtent,
      required this.maxExtent,
      required this.stateSetter,
      required this.title,
      required this.switchVal,
      required this.controller})
      : super();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        child: Row(
      children: <Widget>[
        Text(title),
        IconButton(
          icon: const Icon(Icons.expand_less),
          isSelected: switchVal,
          selectedIcon: const Icon(Icons.expand_more),
          onPressed: () {
            (controller, setState) => _toggleController;
          },
        )
      ],
    ));
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration =>
      FloatingHeaderSnapConfiguration(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
      );
}
