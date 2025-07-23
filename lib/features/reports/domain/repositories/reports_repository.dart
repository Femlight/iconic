import 'package:dartz/dartz.dart';
import '../entities/report.dart';
import '../../../../core/error/failures.dart';

abstract class ReportsRepository {
  Future<Either<Failure, List<Report>>> getReports();
  Future<Either<Failure, Report>> createReport({
    required String title,
    required String description,
    required String category,
    required String location,
    double? latitude,
    double? longitude,
    required List<String> mediaUrls,
  });
}
