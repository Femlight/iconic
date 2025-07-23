import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/report.dart';
import '../repositories/reports_repository.dart';
import '../../../../core/error/failures.dart';

class CreateReportUseCase {
  final ReportsRepository repository;

  CreateReportUseCase(this.repository);

  Future<Either<Failure, Report>> call(CreateReportParams params) async {
    return await repository.createReport(
      title: params.title,
      description: params.description,
      category: params.category,
      location: params.location,
      latitude: params.latitude,
      longitude: params.longitude,
      mediaUrls: params.mediaUrls,
    );
  }
}

class CreateReportParams extends Equatable {
  final String title;
  final String description;
  final String category;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<String> mediaUrls;

  const CreateReportParams({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    this.latitude,
    this.longitude,
    required this.mediaUrls,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    category,
    location,
    latitude,
    longitude,
    mediaUrls,
  ];
}
