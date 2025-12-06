import '../models/trip.dart';
import '../models/trip_request.dart';

class TripService {
  // Mock data - replace with actual API calls
  final List<Trip> _trips = [];
  final List<TripRequest> _requests = [];

  Future<List<Trip>> searchTrips({
    String? origin,
    String? destination,
    DateTime? date,
    int? passengerCount,
  }) async {
    // TODO: Implement actual search logic
    // For now, return mock trips
    return _trips.where((trip) {
      if (origin != null &&
          !trip.origin.toLowerCase().contains(origin.toLowerCase())) {
        return false;
      }
      if (destination != null &&
          !trip.destination.toLowerCase().contains(destination.toLowerCase())) {
        return false;
      }
      if (date != null) {
        final tripDate = DateTime(
          trip.departureTime.year,
          trip.departureTime.month,
          trip.departureTime.day,
        );
        final searchDate = DateTime(date.year, date.month, date.day);
        if (tripDate != searchDate) return false;
      }
      if (passengerCount != null && trip.availableSeats < passengerCount) {
        return false;
      }
      return trip.status == TripStatus.upcoming;
    }).toList();
  }

  Future<List<Trip>> getDriverTrips(String driverId) async {
    return _trips.where((trip) => trip.driverId == driverId).toList();
  }

  Future<Trip> createTrip({
    required String driverId,
    required String origin,
    required String destination,
    required DateTime departureTime,
    required double totalFare,
    required int totalSeats,
    required VehicleInfo vehicleInfo,
    String? policies,
  }) async {
    final trip = Trip(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      driverId: driverId,
      origin: origin,
      destination: destination,
      departureTime: departureTime,
      totalFare: totalFare,
      availableSeats: totalSeats,
      totalSeats: totalSeats,
      vehicleInfo: vehicleInfo,
      policies: policies,
      createdAt: DateTime.now(),
    );
    _trips.add(trip);
    return trip;
  }

  Future<TripRequest> requestTrip({
    required String tripId,
    required String passengerId,
    int requestedSeats = 1,
  }) async {
    final request = TripRequest(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      tripId: tripId,
      passengerId: passengerId,
      requestedSeats: requestedSeats,
      createdAt: DateTime.now(),
    );
    _requests.add(request);
    return request;
  }

  Future<void> approveRequest(String requestId) async {
    final request = _requests.firstWhere((r) => r.id == requestId);
    final index = _requests.indexOf(request);
    _requests[index] = TripRequest(
      id: request.id,
      tripId: request.tripId,
      passengerId: request.passengerId,
      status: RequestStatus.approved,
      requestedSeats: request.requestedSeats,
      createdAt: request.createdAt,
    );

    // Update trip available seats
    final trip = _trips.firstWhere((t) => t.id == request.tripId);
    final tripIndex = _trips.indexOf(trip);
    _trips[tripIndex] = Trip(
      id: trip.id,
      driverId: trip.driverId,
      origin: trip.origin,
      destination: trip.destination,
      departureTime: trip.departureTime,
      totalFare: trip.totalFare,
      availableSeats: trip.availableSeats - request.requestedSeats,
      totalSeats: trip.totalSeats,
      vehicleInfo: trip.vehicleInfo,
      status: trip.status,
      policies: trip.policies,
      createdAt: trip.createdAt,
    );
  }

  Future<void> denyRequest(String requestId) async {
    final request = _requests.firstWhere((r) => r.id == requestId);
    final index = _requests.indexOf(request);
    _requests[index] = TripRequest(
      id: request.id,
      tripId: request.tripId,
      passengerId: request.passengerId,
      status: RequestStatus.denied,
      requestedSeats: request.requestedSeats,
      createdAt: request.createdAt,
    );
  }

  Future<List<TripRequest>> getTripRequests(String tripId) async {
    return _requests.where((r) => r.tripId == tripId).toList();
  }

  Future<List<TripRequest>> getPendingRequests(String driverId) async {
    final driverTrips = _trips
        .where((t) => t.driverId == driverId)
        .map((t) => t.id)
        .toList();
    return _requests
        .where(
          (r) =>
              driverTrips.contains(r.tripId) &&
              r.status == RequestStatus.pending,
        )
        .toList();
  }
}
