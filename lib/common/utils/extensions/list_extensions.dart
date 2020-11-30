extension ListExtensions<T> on List<T> {
  bool containsWhere(bool Function(T) function) {
    final foundObject = firstWhere(
      function,
      orElse: () => null,
    );
    return foundObject != null;
  }
}
