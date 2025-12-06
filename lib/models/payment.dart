class Payment {
  final String id;
  final String tripId;
  final String passengerId;
  final String driverId;
  final double amount;
  final double platformCommission;
  final double driverEarnings;
  final PaymentStatus status;
  final String paymentMethod;
  final DateTime createdAt;

  Payment({
    required this.id,
    required this.tripId,
    required this.passengerId,
    required this.driverId,
    required this.amount,
    required this.platformCommission,
    required this.driverEarnings,
    this.status = PaymentStatus.pending,
    required this.paymentMethod,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tripId': tripId,
      'passengerId': passengerId,
      'driverId': driverId,
      'amount': amount,
      'platformCommission': platformCommission,
      'driverEarnings': driverEarnings,
      'status': status.toString().split('.').last,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] as String,
      tripId: json['tripId'] as String,
      passengerId: json['passengerId'] as String,
      driverId: json['driverId'] as String,
      amount: (json['amount'] as num).toDouble(),
      platformCommission: (json['platformCommission'] as num).toDouble(),
      driverEarnings: (json['driverEarnings'] as num).toDouble(),
      status: PaymentStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => PaymentStatus.pending,
      ),
      paymentMethod: json['paymentMethod'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum PaymentStatus { pending, completed, refunded }
