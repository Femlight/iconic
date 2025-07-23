import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import '../../domain/usecases/search_address_usecase.dart';
import '../../../../core/error/failures.dart';

// Events
abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentLocationEvent extends LocationEvent {}

class SearchAddressEvent extends LocationEvent {
  final String query;

  const SearchAddressEvent({required this.query});

  @override
  List<Object> get props => [query];
}

// States
abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String address;
  final double latitude;
  final double longitude;

  const LocationLoaded({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [address, latitude, longitude];
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final SearchAddressUseCase searchAddressUseCase;

  LocationBloc({
    required this.getCurrentLocationUseCase,
    required this.searchAddressUseCase,
  }) : super(LocationInitial()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
    on<SearchAddressEvent>(_onSearchAddress);
  }

  Future<void> _onGetCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    final result = await getCurrentLocationUseCase(NoParams());

    result.fold(
      (failure) => emit(LocationError(message: _mapFailureToMessage(failure))),
      (location) => emit(
        LocationLoaded(
          address: location.address,
          latitude: location.latitude,
          longitude: location.longitude,
        ),
      ),
    );
  }

  Future<void> _onSearchAddress(
    SearchAddressEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(LocationLoading());

    final result = await searchAddressUseCase(
      SearchAddressParams(query: event.query),
    );

    result.fold(
      (failure) => emit(LocationError(message: _mapFailureToMessage(failure))),
      (locations) => {
        if (locations.isNotEmpty)
          emit(
            LocationLoaded(
              address: locations.first.address,
              latitude: locations.first.latitude,
              longitude: locations.first.longitude,
            ),
          )
        else
          emit(const LocationError(message: 'No locations found')),
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case LocationFailure:
        return 'Location permission denied or unavailable';
      case NetworkFailure:
        return 'Network error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}
