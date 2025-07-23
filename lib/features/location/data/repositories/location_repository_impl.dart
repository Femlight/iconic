import 'package:dartz/dartz.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';
import '../../../../core/error/failures.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, LocationEntity>> getCurrentLocation() async {
    try {
      final location = await dataSource.getCurrentLocation();
      return Right(location);
    } catch (e) {
      return Left(LocationFailure());
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> searchAddress(
    String query,
  ) async {
    try {
      final locations = await dataSource.searchAddress(query);
      return Right(locations);
    } catch (e) {
      return Left(NetworkFailure());
    }
  }
}
