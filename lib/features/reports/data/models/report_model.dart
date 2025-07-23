import '../../domain/entities/report.dart';

class ReportModel extends Report {
  const ReportModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.location,
    super.latitude,
    super.longitude,
    required super.mediaUrls,
    required super.createdAt,
    required super.userId,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      location: json['location'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      mediaUrls: List<String>.from(json['mediaUrls']),
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'mediaUrls': mediaUrls,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
    };
  }
}
