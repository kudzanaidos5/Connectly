import 'package:flutter/material.dart';
import '../../widgets/gradient_header.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _originController = TextEditingController(text: 'Harare CBD');
  final _destinationController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _availableSeats = 4;
  final _fareController = TextEditingController();
  String _vehicleType = 'Toyota Corolla';
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _originController.dispose();
    _destinationController.dispose();
    _fareController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
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

  Future<void> _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  void _submitTrip() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    // TODO: Create trip using provider
    // final departureTime = DateTime(
    //   _selectedDate!.year,
    //   _selectedDate!.month,
    //   _selectedDate!.day,
    //   _selectedTime!.hour,
    //   _selectedTime!.minute,
    // );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Trip created successfully!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GradientHeader(
            title: 'Create New Trip',
            subtitle: 'Set your route and preferences',
            isDriver: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _originController,
                        decoration: const InputDecoration(
                          labelText: 'Starting Location',
                          hintText: 'e.g., Corner House, Harare CBD',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter starting location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _destinationController,
                        decoration: const InputDecoration(
                          labelText: 'Destination',
                          hintText: 'e.g., Unit L, Chitungwiza',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter destination';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: _selectDate,
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                ),
                                child: Text(
                                  _selectedDate != null
                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : 'Select date',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: _selectTime,
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Time',
                                ),
                                child: Text(
                                  _selectedTime != null
                                      ? _selectedTime!.format(context)
                                      : 'Select time',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _availableSeats,
                              decoration: const InputDecoration(
                                labelText: 'Available Seats',
                              ),
                              items: [1, 2, 3, 4]
                                  .map(
                                    (seats) => DropdownMenuItem(
                                      value: seats,
                                      child: Text(
                                        '$seats Seat${seats > 1 ? 's' : ''}',
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _availableSeats = value ?? 4),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _fareController,
                              decoration: const InputDecoration(
                                labelText: 'Base Fare (USD)',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Invalid amount';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        initialValue: _vehicleType,
                        decoration: const InputDecoration(
                          labelText: 'Vehicle Type',
                        ),
                        items:
                            const [
                                  'Toyota Corolla',
                                  'Honda Fit',
                                  'Mazda Demio',
                                  'Nissan Note',
                                  'Other',
                                ]
                                .map(
                                  (vehicle) => DropdownMenuItem(
                                    value: vehicle,
                                    child: Text(vehicle),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) => setState(
                          () => _vehicleType = value ?? 'Toyota Corolla',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Additional Notes (Optional)',
                          hintText:
                              'Any special instructions or preferences...',
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: _submitTrip,
                        child: const Text('Publish trip'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
