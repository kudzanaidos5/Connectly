import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../utils/app_colors.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback? onTap;
  final bool isDriver;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
    required this.isDriver,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: AppColors.getPrimaryColor(isDriver),
                width: 4,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDriver) _buildStatusBadge(),
              const SizedBox(height: 10),
              _buildRoute(),
              const SizedBox(height: 12),
              _buildTripInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color badgeColor;
    String statusText;

    switch (trip.status) {
      case TripStatus.inProgress:
        badgeColor = AppColors.success;
        statusText = 'ACTIVE';
        break;
      case TripStatus.upcoming:
        badgeColor = AppColors.warning;
        statusText = 'SCHEDULED';
        break;
      case TripStatus.completed:
        badgeColor = AppColors.textMedium;
        statusText = 'COMPLETED';
        break;
      case TripStatus.cancelled:
        badgeColor = AppColors.error;
        statusText = 'CANCELLED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        statusText,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRoute() {
    return Column(
      children: [
        _buildRouteItem(trip.origin, true),
        const SizedBox(height: 8),
        _buildRouteItem(trip.destination, false),
      ],
    );
  }

  Widget _buildRouteItem(String location, bool isStart) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isStart ? AppColors.success : AppColors.error,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            location,
            style: const TextStyle(fontSize: 14, color: AppColors.textDark),
          ),
        ),
      ],
    );
  }

  Widget _buildTripInfo() {
    if (isDriver) {
      return Row(
        children: [
          Expanded(
            child: _buildInfoBox('Departure', _formatTime(trip.departureTime)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              'Base Fare',
              '\$${trip.totalFare.toStringAsFixed(2)}',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              'Seats',
              '${trip.totalSeats - trip.availableSeats}/${trip.totalSeats}',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              'Earnings',
              '\$${trip.driverEarnings.toStringAsFixed(2)}',
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          _buildInfoItem(Icons.access_time, _formatTime(trip.departureTime)),
          const SizedBox(width: 15),
          _buildInfoItem(Icons.event_seat, '${trip.availableSeats} seats left'),
          const SizedBox(width: 15),
          _buildInfoItem(Icons.directions_car, trip.vehicleInfo.displayName),
        ],
      );
    }
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMedium),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textMedium),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: AppColors.textMedium),
        ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}
