import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ImagePicker _picker = ImagePicker();
  String _message = '';

  Future<void> _pickAndSaveImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() => _message = 'Saving image...');

        final bool? success = await GallerySaver.saveImage(image.path);
        setState(() {
          _message = success == true ? 'Image saved!' : 'Failed to save image';
        });
      }
    } catch (e) {
      setState(() => _message = 'Error: $e');
    }
  }

  Future<void> _pickAndSaveVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
      if (video != null) {
        setState(() => _message = 'Saving video...');

        final bool? success = await GallerySaver.saveVideo(video.path);
        setState(() {
          _message = success == true ? 'Video saved!' : 'Failed to save video';
        });
      }
    } catch (e) {
      setState(() => _message = 'Error: $e');
    }
  }

  Future<void> _saveNetworkImage() async {
    const url = 'https://picsum.photos/800/600';
    setState(() => _message = 'Saving network image...');

    final bool? success = await GallerySaver.saveImage(url);
    setState(() {
      _message =
          success == true ? 'Network image saved!' : 'Failed to save image';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery Saver Plus'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_message.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    _message,
                    style: TextStyle(color: Colors.blue.shade800),
                    textAlign: TextAlign.center,
                  ),
                ),
              ElevatedButton.icon(
                onPressed: _pickAndSaveImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo & Save'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickAndSaveVideo,
                icon: const Icon(Icons.videocam),
                label: const Text('Record Video & Save'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _saveNetworkImage,
                icon: const Icon(Icons.download),
                label: const Text('Save Network Image'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
