import 'dart:math';

extension ListExtensions<T> on List<T> {
  /// Just a convenience wrap around [map] and [toList].
  List<R> mapList<R>(R Function(T value) mapper) {
    final List<R> finalList = [];

    for (final T value in this) {
      finalList.add(mapper(value));
    }

    return finalList;
  }

  /// Just a convenience wrap around [where] and [toList].
  List<T> whereList(bool Function(T value) test) {
    final List<T> finalList = [];

    for (final T value in this) {
      if (test(value)) {
        finalList.add(value);
      }
    }

    return finalList;
  }

  /// Attempts to return a random elements from `this` list.
  ///
  /// Returns `null` if the list is empty,
  /// returns random [T] otherwise.
  T? get tryRandom {
    if (isEmpty) {
      return null;
    }

    final int randomIndex = Random().nextInt(length);

    return this[randomIndex];
  }

  T? tryAt(int i) {
    try {
      return this[i];
    } catch (e) {
      return null;
    }
  }

  void toggle(T item) {
    if (contains(item)) {
      remove(item);
    } else {
      add(item);
    }
  }
}
