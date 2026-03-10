import 'package:flutter/material.dart';

class ExpandedSingleChildScrollView extends StatelessWidget {
  final Widget? child;
  final ScrollPhysics? physics;
  final ScrollController? controller;

  const ExpandedSingleChildScrollView({
    super.key,
    required this.child,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return SingleChildScrollView(
          physics: physics,
          controller: controller,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
