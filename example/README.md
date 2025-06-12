# Gallery Saver Plus Example

This example demonstrates how to use the `gallery_saver_plus` plugin to save images and videos to the device's gallery.

## Features Demonstrated

This example app showcases three main features:

1. **Save Camera Photos**: Take a photo using the device's camera and save it to the gallery
2. **Save Camera Videos**: Record a video using the device's camera and save it to the gallery
3. **Save Network Images**: Download an image from the internet and save it to the gallery

## Getting Started

### Prerequisites

- Flutter SDK installed
- Android Studio / Xcode for device testing
- Physical device or emulator with camera support

### Running the Example

1. Navigate to the example directory:
   ```bash
   cd example
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Usage

The app provides three buttons:

- **Take Photo & Save**: Opens the camera to take a photo, then saves it to the device gallery
- **Record Video & Save**: Opens the camera to record a video, then saves it to the device gallery
- **Save Network Image**: Downloads a sample image from the internet and saves it to the gallery

Status messages will appear at the top of the screen indicating the success or failure of each operation.

## Platform-specific Setup

### iOS
- Requires iOS 9.0 or higher
- Add the following keys to your `Info.plist`:
  - `NSPhotoLibraryUsageDescription` - describe why your app needs photo library access
  - `NSCameraUsageDescription` - describe why your app needs camera access

### Android
- Requires Android API level 21 or higher
- Permissions are handled automatically by the plugin

## Learn More

For more information about the `gallery_saver_plus` plugin, visit:
- [Plugin Homepage](https://github.com/mafreud/gallery_saver_plus)
- [pub.dev Package](https://pub.dev/packages/gallery_saver_plus)

