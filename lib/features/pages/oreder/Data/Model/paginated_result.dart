class PaginatedResult<T> {
  final List<T> items;
  final dynamic
  lastDocument; // Firestore DocumentSnapshot, keep dynamic to avoid import issues

  PaginatedResult({required this.items, this.lastDocument});
}
