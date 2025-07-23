import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../location/presentation/bloc/location_bloc.dart';

class LocationSelector extends StatefulWidget {
  final Function(String location, double? lat, double? lng) onLocationSelected;

  const LocationSelector({super.key, required this.onLocationSelected});

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final _addressController = TextEditingController();
  bool _useCurrentLocation = false;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        if (state is LocationLoaded) {
          if (_useCurrentLocation) {
            setState(() {
              _addressController.text = state.address;
            });
            widget.onLocationSelected(
              state.address,
              state.latitude,
              state.longitude,
            );
          }
        } else if (state is LocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Column(
        children: [
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address',
              hintText: 'Enter location or use current location',
              suffixIcon: IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: () {
                  setState(() {
                    _useCurrentLocation = true;
                  });
                  context.read<LocationBloc>().add(GetCurrentLocationEvent());
                },
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && !_useCurrentLocation) {
                widget.onLocationSelected(value, null, null);
              }
            },
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a location';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationLoading) {
                return const LinearProgressIndicator();
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
