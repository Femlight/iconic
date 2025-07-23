import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/capture_image_usecase.dart';
import '../../domain/usecases/capture_video_usecase.dart';
import '../../domain/usecases/pick_media_usecase.dart';
import '../../../../core/error/failures.dart';

// Events
abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CaptureImageEvent extends CameraEvent {}

class CaptureVideoEvent extends CameraEvent {}

class PickMediaEvent extends CameraEvent {}

// States
abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraMediaCaptured extends CameraState {
  final String mediaPath;

  const CameraMediaCaptured({required this.mediaPath});

  @override
  List<Object> get props => [mediaPath];
}

class CameraError extends CameraState {
  final String message;

  const CameraError({required this.message});

  @override
  List<Object> get props => [message];
}

// BLoC
class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CaptureImageUseCase captureImageUseCase;
  final CaptureVideoUseCase captureVideoUseCase;
  final PickMediaUseCase pickMediaUseCase;

  CameraBloc({
    required this.captureImageUseCase,
    required this.captureVideoUseCase,
    required this.pickMediaUseCase,
  }) : super(CameraInitial()) {
    on<CaptureImageEvent>(_onCaptureImage);
    on<CaptureVideoEvent>(_onCaptureVideo);
    on<PickMediaEvent>(_onPickMedia);
  }

  Future<void> _onCaptureImage(
    CaptureImageEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());

    final result = await captureImageUseCase(NoParams());

    result.fold(
      (failure) => emit(CameraError(message: _mapFailureToMessage(failure))),
      (imagePath) => emit(CameraMediaCaptured(mediaPath: imagePath)),
    );
  }

  Future<void> _onCaptureVideo(
    CaptureVideoEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());

    final result = await captureVideoUseCase(NoParams());

    result.fold(
      (failure) => emit(CameraError(message: _mapFailureToMessage(failure))),
      (videoPath) => emit(CameraMediaCaptured(mediaPath: videoPath)),
    );
  }

  Future<void> _onPickMedia(
    PickMediaEvent event,
    Emitter<CameraState> emit,
  ) async {
    emit(CameraLoading());

    final result = await pickMediaUseCase(NoParams());

    result.fold(
      (failure) => emit(CameraError(message: _mapFailureToMessage(failure))),
      (mediaPath) => emit(CameraMediaCaptured(mediaPath: mediaPath)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case CameraFailure:
        return 'Camera error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}
