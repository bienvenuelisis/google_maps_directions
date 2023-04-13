///Custom class for exceptions.
class DistanceException implements Exception {
  DistanceException({
    required this.status,
    required this.message,
    this.description,
  });

  final String? description;
  final String message;
  final String status;
}
