import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wallpapers_30/images_response.dart';
import 'package:wallpapers_30/pixabay_api.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;

class WalpaperState with ChangeNotifier {
  final _pixaBayApi = PixabayApi();
  ImagesResponse imagesResponse;
  bool isBusy = false;

  Future<void> fetchImages() async {
    isBusy = true;
    notifyListeners();
    imagesResponse = await _pixaBayApi.getImages();
    isBusy = false;
    notifyListeners();
    // print(imagesResponse);
  }

  Future<void> setwallpaper(String url) async {
    String path = await _saveToDisk(url);
    int location = WallpaperManager
        .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
    String result;
    try {
      result = await WallpaperManager.setWallpaperFromFile(path, location);
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }

  Future<String> _saveToDisk(String _url) async {
    final response = await http.get(_url);

    // Get the image name
    final imageName = path.basename(_url);
    // Get the document directory path
    final appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later.
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    return localPath;
  }
}
