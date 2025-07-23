import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]) : super();
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object> get props => [];
}

class LocationFailure extends Failure {
  @override
  List<Object> get props => [];
}

class CameraFailure extends Failure {
  @override
  List<Object> get props => [];
}

// Use case parameters
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
