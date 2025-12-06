class Trip {
  final String id;
  final String driverId;
  final String origin;
  final String destination;
  final DateTime departureTime;
  final double totalFare;
  final int availableSeats;
  final int totalSeats;
  final VehicleInfo vehicleInfo;
  final TripStatus status;
  final String? policies;
  final DateTime createdAt;

  Trip({
    required this.id,
    required this.driverId,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.totalFare,
    required this.availableSeats,
    required this.totalSeats,
    required this.vehicleInfo,
    this.status = TripStatus.upcoming,
    this.policies,
    required this.createdAt,
  });

  double get pricePerPassenger => totalFare / totalSeats;
  double get driverEarnings => totalFare * 0.8;
  double get platformCommission => totalFare * 0.2;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driverId': driverId,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime.toIso8601String(),
      'totalFare': totalFare,
      'availableSeats': availableSeats,
      'totalSeats': totalSeats,
      'vehicleInfo': vehicleInfo.toJson(),
      'status': status.toString().split('.').last,
      'policies': policies,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as String,
      driverId: json['driverId'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      totalFare: (json['totalFare'] as num).toDouble(),
      availableSeats: json['availableSeats'] as int,
      totalSeats: json['totalSeats'] as int,
      vehicleInfo: VehicleInfo.fromJson(
        json['vehicleInfo'] as Map<String, dynamic>,
      ),
      status: TripStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => TripStatus.upcoming,
      ),
      policies: json['policies'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class VehicleInfo {
  final String make;
  final String model;
  final String registration;
  final String color;

  VehicleInfo({
    required this.make,
    required this.model,
    required this.registration,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'registration': registration,
      'color': color,
    };
  }

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      make: json['make'] as String,
      model: json['model'] as String,
      registration: json['registration'] as String,
      color: json['color'] as String,
    );
  }

  String get displayName => '$make $model';
}

enum TripStatus { upcoming, inProgress, completed, cancelled }
