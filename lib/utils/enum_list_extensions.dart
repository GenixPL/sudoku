import 'package:collection/collection.dart';

extension EnumListExtensions<T extends Enum> on List<T> {
  T? withName(String? name) {
    if (name == null) {
      return null;
    }

    return firstWhereOrNull((e) => e.name == name);
  }
}
