import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';
import '../../../../core/error/failures.dart';

class SearchAddressUseCase {
  final LocationRepository repository;

  SearchAddressUseCase(this.repository);

  Future<Either<Failure, List<LocationEntity>>> call(
    SearchAddressParams params,
  ) async {
    return await repository.searchAddress(params.query);
  }
}

class SearchAddressParams extends Equatable {
  final String query;

  const SearchAddressParams({required this.query});

  @override
  List<Object> get props => [query];
}
