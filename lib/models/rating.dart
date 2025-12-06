class Rating {
  final String id;
  final String tripId;
  final String raterId;
  final String ratedId;
  final int rating; // 1-5
  final String? review;
  final DateTime createdAt;

  Rating({
    required this.id,
    required this.tripId,
    required this.raterId,
    required this.ratedId,
    required this.rating,
    this.review,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'raterId': raterId,
      'ratedId': ratedId,
      'rating': rating,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      raterId: json['raterId'] as String,
      ratedId: json['ratedId'] as String,
      rating: json['rating'] as int,
      review: json['review'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
