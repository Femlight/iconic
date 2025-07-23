import 'package:dartz/dartz.dart';
import '../repositories/camera_repository.dart';
import '../../../../core/error/failures.dart';

class CaptureImageUseCase {
  final CameraRepository repository;

  CaptureImageUseCase(this.repository);

  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.captureImage();
  }
}
