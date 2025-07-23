import 'package:dartz/dartz.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';
import '../../../../core/error/failures.dart';

class GetCurrentLocationUseCase {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<Either<Failure, LocationEntity>> call(NoParams params) async {
    return await repository.getCurrentLocation();
  }
}
