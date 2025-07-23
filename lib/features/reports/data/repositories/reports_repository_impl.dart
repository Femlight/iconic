import 'package:dartz/dartz.dart';
import '../../domain/entities/report.dart';
import '../../domain/repositories/reports_repository.dart';
import '../datasources/reports_local_data_source.dart';
import '../../../../core/error/failures.dart';

class ReportsRepositoryImpl implements ReportsRepository {
  final ReportsLocalDataSource localDataSource;

  ReportsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Report>>> getReports() async {
    try {
      final reports = await localDataSource.getReports();
      return Right(reports);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Report>> createReport({
    required String title,
    required String description,
    required String category,
    required String location,
    double? latitude,
    double? longitude,
    required List<String> mediaUrls,
  }) async {
    try {
      final report = await localDataSource.createReport(
        title: title,
        description: description,
        category: category,
        location: location,
        latitude: latitude,
        longitude: longitude,
        mediaUrls: mediaUrls,
      );
      return Right(report);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
