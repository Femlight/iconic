import 'package:dartz/dartz.dart';
import '../entities/location.dart';
import '../../../../core/error/failures.dart';

abstract class LocationRepository {
  Future<Either<Failure, LocationEntity>> getCurrentLocation();
  Future<Either<Failure, List<LocationEntity>>> searchAddress(String query);
}
