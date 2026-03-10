class PaginatedResult<T> {
  final List<T> items;
  final dynamic firstDocument; // Firestore DocumentSnapshot
  final dynamic lastDocument; // Firestore DocumentSnapshot

  PaginatedResult({required this.items, this.firstDocument, this.lastDocument});
}
