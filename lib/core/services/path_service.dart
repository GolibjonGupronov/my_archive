import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathService {
  static Directory? _cachedVideoPath;
  static Directory? _cachedAudioPath;
  static Directory? _cachedImagePath;

  static Future<Directory> get videosDir async {
    if (_cachedVideoPath != null) return _cachedVideoPath!;
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/videos";
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _cachedVideoPath = dir;
    return dir;
  }

  static Future<Directory> get audiosDir async {
    if (_cachedAudioPath != null) return _cachedAudioPath!;
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/audios";
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _cachedAudioPath = dir;
    return dir;
  }

  static Future<Directory> get imagesDir async {
    if (_cachedImagePath != null) return _cachedImagePath!;
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/images";
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    _cachedImagePath = dir;
    return dir;
  }
}
