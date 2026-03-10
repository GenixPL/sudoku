import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget get sliver {
    return SliverToBoxAdapter(
      child: this,
    );
  }

  Widget withHorizontalPadding(
    double size, {
    bool sliver = false,
  }) {
    final EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: size);

    if (sliver) {
      return SliverPadding(
        padding: edgeInsets,
        sliver: this,
      );
    } else {
      return Padding(
        padding: edgeInsets,
        child: this,
      );
    }
  }
}
