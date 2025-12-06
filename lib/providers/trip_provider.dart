import 'package:flutter/foundation.dart';
import '../models/trip.dart';
import '../models/trip_request.dart';
import '../services/trip_service.dart';

class TripProvider with ChangeNotifier {
  final TripService _tripService = TripService();
  List<Trip> _trips = [];
  List<TripRequest> _requests = [];
  bool _isLoading = false;

  List<Trip> get trips => _trips;
  List<TripRequest> get requests => _requests;
  bool get isLoading => _isLoading;

  Future<void> searchTrips({
    String? origin,
    String? destination,
    DateTime? date,
    int? passengerCount,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _trips = await _tripService.searchTrips(
        origin: origin,
        destination: destination,
        date: date,
        passengerCount: passengerCount,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDriverTrips(String driverId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _trips = await _tripService.getDriverTrips(driverId);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
    final trip = await _tripService.createTrip(
      driverId: driverId,
      origin: origin,
      destination: destination,
      departureTime: departureTime,
      totalFare: totalFare,
      totalSeats: totalSeats,
      vehicleInfo: vehicleInfo,
      policies: policies,
    );
    _trips.add(trip);
    notifyListeners();
    return trip;
  }

  Future<TripRequest> requestTrip({
    required String tripId,
    required String passengerId,
    int requestedSeats = 1,
  }) async {
    final request = await _tripService.requestTrip(
      tripId: tripId,
      passengerId: passengerId,
      requestedSeats: requestedSeats,
    );
    _requests.add(request);
    notifyListeners();
    return request;
  }

  Future<void> approveRequest(String requestId) async {
    await _tripService.approveRequest(requestId);
    await loadDriverTrips(_trips.first.driverId);
    notifyListeners();
  }

  Future<void> denyRequest(String requestId) async {
    await _tripService.denyRequest(requestId);
    notifyListeners();
  }

  Future<void> loadTripRequests(String tripId) async {
    _requests = await _tripService.getTripRequests(tripId);
    notifyListeners();
  }

  Future<void> loadPendingRequests(String driverId) async {
    _requests = await _tripService.getPendingRequests(driverId);
    notifyListeners();
  }
}
