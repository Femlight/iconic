import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final String id;
  final String title;
  final String description;
  final String category;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<String> mediaUrls;
  final DateTime createdAt;
  final String userId;

  const Report({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    this.latitude,
    this.longitude,
    required this.mediaUrls,
    required this.createdAt,
    required this.userId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    category,
    location,
    latitude,
    longitude,
    mediaUrls,
    createdAt,
    userId,
  ];
}
