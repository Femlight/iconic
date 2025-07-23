import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/report.dart';
import '../../domain/usecases/create_report_usecase.dart';
import '../../domain/usecases/get_reports_usecase.dart';
import '../../../../core/error/failures.dart';

// Events
abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class GetReportsEvent extends ReportsEvent {}

class CreateReportEvent extends ReportsEvent {
  final String title;
  final String description;
  final String category;
  final String location;
  final double? latitude;
  final double? longitude;
  final List<String> mediaUrls;

  const CreateReportEvent({
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    this.latitude,
    this.longitude,
    required this.mediaUrls,
  });

  @override
  List<Object> get props => [
    title,
    description,
    category,
    location,
    latitude ?? 0.0,
    longitude ?? 0.0,
    mediaUrls,
  ];
}

// States
abstract class ReportsState extends Equatable {
  const ReportsState();

  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsLoaded extends ReportsState {
  final List<Report> reports;

  const ReportsLoaded({required this.reports});

  @override
  List<Object> get props => [reports];
}

class ReportsError extends ReportsState {
  final String message;

  const ReportsError({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportCreated extends ReportsState {
  final Report report;

  const ReportCreated({required this.report});

  @override
  List<Object> get props => [report];
}

// BLoC
class ReportsBloc extends Bloc<ReportsEvent, ReportsState> {
  final CreateReportUseCase createReportUseCase;
  final GetReportsUseCase getReportsUseCase;

  ReportsBloc({
    required this.createReportUseCase,
    required this.getReportsUseCase,
  }) : super(ReportsInitial()) {
    on<GetReportsEvent>(_onGetReports);
    on<CreateReportEvent>(_onCreateReport);
  }

  Future<void> _onGetReports(
    GetReportsEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(ReportsLoading());

    final result = await getReportsUseCase(NoParams());

    result.fold(
      (failure) => emit(ReportsError(message: _mapFailureToMessage(failure))),
      (reports) => emit(ReportsLoaded(reports: reports)),
    );
  }

  Future<void> _onCreateReport(
    CreateReportEvent event,
    Emitter<ReportsState> emit,
  ) async {
    emit(ReportsLoading());

    final result = await createReportUseCase(
      CreateReportParams(
        title: event.title,
        description: event.description,
        category: event.category,
        location: event.location,
        latitude: event.latitude,
        longitude: event.longitude,
        mediaUrls: event.mediaUrls,
      ),
    );

    result.fold(
      (failure) => emit(ReportsError(message: _mapFailureToMessage(failure))),
      (report) {
        emit(ReportCreated(report: report));
        add(GetReportsEvent()); // Refresh the list
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case CacheFailure:
        return 'Cache error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}
