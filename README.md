# Gallery Saver Plus for Flutter

[![pub package](https://img.shields.io/pub/v/gallery_saver_plus.svg)](https://pub.dev/packages/gallery_saver_plus)

A Flutter plugin to save images and videos from network URLs or local files to the device's gallery. Media files will be visible in Android Gallery and iOS Photos app.

## Features

- ✅ Save images from network URLs or local file paths
- ✅ Save videos from network URLs or local file paths  
- ✅ Support for various image formats (JPEG, PNG, WebP, AVIF)
- ✅ Support for various video formats (MP4, MOV, etc.)
- ✅ Cross-platform support (iOS and Android)
- ✅ Null safety support

## Installation

Add `gallery_saver_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  gallery_saver_plus: latest
```

Or install it from the command line:

```bash
flutter pub add gallery_saver_plus
```

## Platform Setup

### iOS

Add the following key to your `Info.plist` file, located at `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to save images and videos</string>
```

### Android

For Android 10 (API level 29) and below, add this permission to your `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

For Android 11+ (API level 30+), no additional permissions are required.

## Usage

Import the package:

```dart
import 'package:gallery_saver_plus/gallery_saver.dart';
```

### Save Network Image

```dart
final success = await GallerySaver.saveImage(
  'https://example.com/image.jpg'
);
if (success ?? false) {
  print('Image saved to gallery');
}
```

### Save Local Image

```dart
final success = await GallerySaver.saveImage('/path/to/local/image.jpg');
```

### Save Network Video

```dart
final success = await GallerySaver.saveVideo(
  'https://example.com/video.mp4'
);
```

### Save Local Video

```dart
final success = await GallerySaver.saveVideo('/path/to/local/video.mp4');
```

## Complete Example

```dart
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
      _message = success == true ? 'Network image saved!' : 'Failed to save image';
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
```

## API Reference

### GallerySaver.saveImage(String path)

Saves an image to the device gallery.

- **path**: Local file path or network URL (must start with 'http' or 'https')
- **Returns**: `Future<bool?>` - `true` if successful, `false` if failed, `null` if cancelled

### GallerySaver.saveVideo(String path)

Saves a video to the device gallery.

- **path**: Local file path or network URL (must start with 'http' or 'https')  
- **Returns**: `Future<bool?>` - `true` if successful, `false` if failed, `null` if cancelled

## Supported Formats

### Images
- JPEG (.jpg, .jpeg)
- PNG (.png)
- WebP (.webp)
- AVIF (.avif)

### Videos
- MP4 (.mp4)
- MOV (.mov)
- And other formats supported by the platform

## Requirements

- Flutter >=3.0.0
- Dart >=3.0.0
- iOS 11.0+
- Android API level 21+

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.