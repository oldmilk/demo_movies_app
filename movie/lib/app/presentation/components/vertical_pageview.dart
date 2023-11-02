import 'package:flutter/material.dart';

class VerticalPageView extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function addEvent;

  const VerticalPageView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.addEvent,
  });

  @override
  State<VerticalPageView> createState() => _VerticalPageViewState();
}

class _VerticalPageViewState extends State<VerticalPageView> {
  final PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: controller,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }

  void _onScroll() {
    if (controller.position.atEdge) {
      if (controller.position.pixels != 0) {
        widget.addEvent();
      }
    }
  }
}
