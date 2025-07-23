import 'package:image_picker/image_picker.dart';

abstract class CameraDataSource {
  Future<String> captureImage();
  Future<String> captureVideo();
  Future<String> pickMedia();
}

class CameraDataSourceImpl implements CameraDataSource {
  final ImagePicker imagePicker;

  CameraDataSourceImpl({required this.imagePicker});

  @override
  Future<String> captureImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (image == null) {
      throw Exception('No image captured');
    }

    return image.path;
  }

  @override
  Future<String> captureVideo() async {
    final XFile? video = await imagePicker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 5),
    );

    if (video == null) {
      throw Exception('No video captured');
    }

    return video.path;
  }

  @override
  Future<String> pickMedia() async {
    final XFile? media = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (media == null) {
      throw Exception('No media selected');
    }

    return media.path;
  }
}
