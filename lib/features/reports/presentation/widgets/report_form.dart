import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reports_bloc.dart';
import '../../../location/presentation/bloc/location_bloc.dart';
import '../../../camera/presentation/bloc/camera_bloc.dart';
import '../widgets/location_selector.dart';
import '../widgets/media_selector.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Infrastructure';
  String _selectedLocation = '';
  double? _latitude;
  double? _longitude;
  List<String> _mediaUrls = [];

  final List<String> _categories = [
    'Infrastructure',
    'Safety',
    'Environment',
    'Maintenance',
    'Security',
    'Other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Report Title',
              hintText: 'Enter a descriptive title',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(labelText: 'Category'),
            items: _categories.map((category) {
              return DropdownMenuItem(value: category, child: Text(category));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Describe the issue in detail',
            ),
            maxLines: 4,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          const Text(
            'Location',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          LocationSelector(
            onLocationSelected: (location, lat, lng) {
              setState(() {
                _selectedLocation = location;
                _latitude = lat;
                _longitude = lng;
              });
            },
          ),
          const SizedBox(height: 24),

          const Text(
            'Attachments',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          MediaSelector(
            onMediaSelected: (urls) {
              setState(() {
                _mediaUrls = urls;
              });
            },
          ),
          const SizedBox(height: 32),

          BlocBuilder<ReportsBloc, ReportsState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state is ReportsLoading
                      ? null
                      : _selectedLocation.isEmpty
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ReportsBloc>().add(
                              CreateReportEvent(
                                title: _titleController.text.trim(),
                                description: _descriptionController.text.trim(),
                                category: _selectedCategory,
                                location: _selectedLocation,
                                latitude: _latitude,
                                longitude: _longitude,
                                mediaUrls: _mediaUrls,
                              ),
                            );
                          }
                        },
                  child: state is ReportsLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Report'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
