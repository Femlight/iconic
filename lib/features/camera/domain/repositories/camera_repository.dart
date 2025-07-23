import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class CameraRepository {
  Future<Either<Failure, String>> captureImage();
  Future<Either<Failure, String>> captureVideo();
  Future<Either<Failure, String>> pickMedia();
}
