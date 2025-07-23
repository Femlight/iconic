import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../camera/presentation/bloc/camera_bloc.dart';
import 'dart:io';

class MediaSelector extends StatefulWidget {
  final Function(List<String>) onMediaSelected;

  const MediaSelector({super.key, required this.onMediaSelected});

  @override
  State<MediaSelector> createState() => _MediaSelectorState();
}

class _MediaSelectorState extends State<MediaSelector> {
  List<String> _mediaUrls = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state is CameraMediaCaptured) {
          setState(() {
            _mediaUrls.add(state.mediaPath);
          });
          widget.onMediaSelected(_mediaUrls);
        } else if (state is CameraError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showMediaOptions(context),
                  icon: const Icon(Icons.add_a_photo),
                  label: const Text('Add Photo/Video'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_mediaUrls.isNotEmpty) ...[
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _mediaUrls.length,
                itemBuilder: (context, index) {
                  final mediaPath = _mediaUrls[index];
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(mediaPath),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _mediaUrls.removeAt(index);
                              });
                              widget.onMediaSelected(_mediaUrls);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _showMediaOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                context.read<CameraBloc>().add(CaptureImageEvent());
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Record Video'),
              onTap: () {
                Navigator.pop(context);
                context.read<CameraBloc>().add(CaptureVideoEvent());
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                context.read<CameraBloc>().add(PickMediaEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
