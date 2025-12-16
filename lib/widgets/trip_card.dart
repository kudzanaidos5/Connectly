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
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(left: BorderSide(color: scheme.primary, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isDriver) _buildStatusBadge(),
              const SizedBox(height: 10),
              _buildRoute(context),
              const SizedBox(height: 12),
              _buildTripInfo(context),
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

  Widget _buildRoute(BuildContext context) {
    return Column(
      children: [
        _buildRouteItem(context, trip.origin, true),
        const SizedBox(height: 8),
        _buildRouteItem(context, trip.destination, false),
      ],
    );
  }

  Widget _buildRouteItem(BuildContext context, String location, bool isStart) {
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
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildTripInfo(BuildContext context) {
    if (isDriver) {
      return Row(
        children: [
          Expanded(
            child: _buildInfoBox(
              context,
              'Departure',
              _formatTime(trip.departureTime),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              context,
              'Base Fare',
              '\$${trip.totalFare.toStringAsFixed(2)}',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              context,
              'Seats',
              '${trip.totalSeats - trip.availableSeats}/${trip.totalSeats}',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildInfoBox(
              context,
              'Earnings',
              '\$${trip.driverEarnings.toStringAsFixed(2)}',
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          _buildInfoItem(
            context,
            Icons.access_time,
            _formatTime(trip.departureTime),
          ),
          const SizedBox(width: 15),
          _buildInfoItem(
            context,
            Icons.event_seat,
            '${trip.availableSeats} seats left',
          ),
          const SizedBox(width: 15),
          _buildInfoItem(
            context,
            Icons.directions_car,
            trip.vehicleInfo.displayName,
          ),
        ],
      );
    }
  }

  Widget _buildInfoBox(BuildContext context, String label, String value) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, IconData icon, String text) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 16, color: scheme.onSurfaceVariant),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
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
