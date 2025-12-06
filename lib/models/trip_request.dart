class TripRequest {
  final String id;
  final String tripId;
  final String passengerId;
  final RequestStatus status;
  final int requestedSeats;
  final DateTime createdAt;

  TripRequest({
    required this.id,
    required this.tripId,
    required this.passengerId,
    this.status = RequestStatus.pending,
    this.requestedSeats = 1,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'passengerId': passengerId,
      'status': status.toString().split('.').last,
      'requestedSeats': requestedSeats,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TripRequest.fromJson(Map<String, dynamic> json) {
    return TripRequest(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      passengerId: json['passengerId'] as String,
      status: RequestStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => RequestStatus.pending,
      ),
      requestedSeats: json['requestedSeats'] as int? ?? 1,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum RequestStatus { pending, approved, denied }
