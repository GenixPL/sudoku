import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sudoku/utils/_utils.dart';

extension WidgetListExtensions on List<Widget> {
  /// Puts [Gap] in between "this" list's widgets.
  List<Widget> withGaps(
    double size, {
    bool sliver = false,
  }) {
    if (size <= 0) {
      return this;
    }

    if (length <= 1) {
      return this;
    }

    return List.generate(
      length * 2 - 1,
      (index) {
        if (index.isEven) {
          return this[index ~/ 2];
        }

        if (sliver) {
          return SliverGap(size);
        } else {
          return Gap(size);
        }
      },
    );
  }

  /// Does the same as [withGaps], and adds the same spacing before the first and after the last child.
  List<Widget> withGapsAndPadding(
    double size, {
    bool sliver = false,
  }) {
    if (size <= 0) {
      return this;
    }

    if (isEmpty) {
      return this;
    }

    return [
      if (sliver) SliverGap(size) else Gap(size),

      ...withGaps(
        size,
        sliver: sliver,
      ),

      if (sliver) SliverGap(size) else Gap(size),
    ];
  }

  List<Widget> withHorizontalPadding(
    double size, {
    bool sliver = false,
  }) {
    return mapList(
      (Widget child) => child.withHorizontalPadding(
        size,
        sliver: sliver,
      ),
    );
  }

  List<Widget> get slivers {
    return mapList((Widget child) => child.sliver);
  }

  /// Wraps `this` list of [Widget]s with [SafeArea].
  ///
  /// The first widget receives the top and the last the bottom
  /// (they might be the same in which case it will receive both).
  ///
  /// WORK
  /// Anything that isn't first or last will be left as it is, which
  /// might be a problem in case of left and right. Subject to potential
  /// changes.
  List<Widget> withSafeArea({
    bool sliver = false,
  }) {
    final List<Widget> toReturn = [];

    for (int i = 0; i < length; i++) {
      final Widget widget = this[i];
      final bool isFirst = (i == 0);
      final bool isLast = (i == (length - 1));

      if (!isFirst && !isLast) {
        // Neither first nor last.
        toReturn.add(widget);
        continue;
      }

      if (sliver) {
        toReturn.add(
          SliverSafeArea(
            top: isFirst,
            bottom: isLast,
            sliver: widget,
          ),
        );
      } else {
        toReturn.add(
          SafeArea(
            top: isFirst,
            bottom: isLast,
            child: widget,
          ),
        );
      }
    }

    return toReturn;
  }
}
