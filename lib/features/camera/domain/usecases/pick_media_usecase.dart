import 'package:dartz/dartz.dart';
import '../repositories/camera_repository.dart';
import '../../../../core/error/failures.dart';

class PickMediaUseCase {
  final CameraRepository repository;

  PickMediaUseCase(this.repository);

  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.pickMedia();
  }
}
