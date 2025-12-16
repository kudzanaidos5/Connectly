import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/gradient_header.dart';
import '../../widgets/trip_card.dart';
import '../../utils/app_colors.dart';
import 'trip_details_screen.dart';
import 'my_rides_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';

class PassengerHomeScreen extends StatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  State<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends State<PassengerHomeScreen> {
  int _currentIndex = 0;
  final _fromController = TextEditingController(text: 'Harare CBD');
  final _toController = TextEditingController(text: 'Chitungwiza');
  DateTime? _selectedDate;
  int _passengerCount = 1;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _searchTrips() {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
    tripProvider.searchTrips(
      origin: _fromController.text,
      destination: _toController.text,
      date: _selectedDate,
      passengerCount: _passengerCount,
    );
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex != 0) {
      return _buildOtherPages();
    }

    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        isDriver: false,
      ),
      body: Column(
        children: [
          GradientHeader(
            title: 'Connectly',
            subtitle: 'Find your ride. Share the cost.',
            isDriver: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [_buildSearchSection(), _buildTripsList()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherPages() {
    switch (_currentIndex) {
      case 1:
        return MyRidesScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      case 2:
        return MessagesScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      case 3:
        return ProfileScreen(
          onNavTap: (index) => setState(() => _currentIndex = index),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  TextField(
                    controller: _fromController,
                    decoration: const InputDecoration(
                      labelText: 'From',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _toController,
                    decoration: const InputDecoration(
                      labelText: 'To',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _selectDate,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'When',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _selectedDate != null
                                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                  : 'Select date',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          initialValue: _passengerCount,
                          decoration: const InputDecoration(
                            labelText: 'Passengers',
                            prefixIcon: Icon(Icons.people),
                          ),
                          items: [1, 2, 3, 4]
                              .map(
                                (count) => DropdownMenuItem(
                                  value: count,
                                  child: Text(
                                    '$count Passenger${count > 1 ? 's' : ''}',
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) =>
                              setState(() => _passengerCount = value ?? 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _searchTrips,
              icon: const Icon(Icons.search),
              label: const Text('Search available rides'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripsList() {
    return Consumer<TripProvider>(
      builder: (context, tripProvider, _) {
        if (tripProvider.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(40),
            child: CircularProgressIndicator(),
          );
        }

        if (tripProvider.trips.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Icon(Icons.search, size: 60, color: AppColors.textLight),
                const SizedBox(height: 16),
                Text(
                  'No trips found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search criteria',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Available Rides (${tripProvider.trips.length})',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 10),
            ...tripProvider.trips.map(
              (trip) => TripCard(
                trip: trip,
                isDriver: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TripDetailsScreen(trip: trip),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
