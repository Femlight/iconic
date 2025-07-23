import 'package:dartz/dartz.dart';
import '../entities/report.dart';
import '../repositories/reports_repository.dart';
import '../../../../core/error/failures.dart';

class GetReportsUseCase {
  final ReportsRepository repository;

  GetReportsUseCase(this.repository);

  Future<Either<Failure, List<Report>>> call(NoParams params) async {
    return await repository.getReports();
  }
}
