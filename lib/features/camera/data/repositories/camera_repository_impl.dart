import 'package:dartz/dartz.dart';
import '../../domain/repositories/camera_repository.dart';
import '../datasources/camera_data_source.dart';
import '../../../../core/error/failures.dart';

class CameraRepositoryImpl implements CameraRepository {
  final CameraDataSource dataSource;

  CameraRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, String>> captureImage() async {
    try {
      final imagePath = await dataSource.captureImage();
      return Right(imagePath);
    } catch (e) {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, String>> captureVideo() async {
    try {
      final videoPath = await dataSource.captureVideo();
      return Right(videoPath);
    } catch (e) {
      return Left(CameraFailure());
    }
  }

  @override
  Future<Either<Failure, String>> pickMedia() async {
    try {
      final mediaPath = await dataSource.pickMedia();
      return Right(mediaPath);
    } catch (e) {
      return Left(CameraFailure());
    }
  }
}
