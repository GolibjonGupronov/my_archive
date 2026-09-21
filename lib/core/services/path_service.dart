import 'dart:io';

import 'package:my_archive/core/enums/common.dart';
import 'package:path_provider/path_provider.dart';

class PathService {
  static final Map<String, Directory> _cache = {};

  static Future<Directory> _getOrCreateDir(String folderName) async {
    if (_cache.containsKey(folderName)) {
      return _cache[folderName]!;
    }

    final baseDir = await getApplicationDocumentsDirectory();
    final dir = Directory("${baseDir.path}/$folderName");

    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _cache[folderName] = dir;
    return dir;
  }

  static Future<double> _getDirectorySize(Directory dir) async {
    double totalSize = 0;

    try {
      if (await dir.exists()) {
        await for (final FileSystemEntity entity in dir.list(recursive: true, followLinks: false)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (_) {}

    return totalSize;
  }

  static Future<Directory> get videosDir => _getOrCreateDir(FolderType.video.key);
  static Future<Directory> get audiosDir => _getOrCreateDir(FolderType.audio.key);
  static Future<Directory> get imagesDir => _getOrCreateDir(FolderType.image.key);
  static Future<Directory> get filesDir => _getOrCreateDir(FolderType.file.key);

  static Future<double> get videosBytes async => _getDirectorySize(await videosDir);
  static Future<double> get audiosBytes async => _getDirectorySize(await audiosDir);
  static Future<double> get imagesBytes async => _getDirectorySize(await imagesDir);
  static Future<double> get filesBytes async => _getDirectorySize(await filesDir);


  static Future<void> _clearDirContents(Directory dir) async {
    if (!await dir.exists()) return;

    await for (final entity in dir.list()) {
      try {
        if (entity is Directory) {
          await entity.delete(recursive: true);
        } else {
          await entity.delete();
        }
      } catch (_) {}
    }
  }

  static Future<void> clearVideos() async {
    final dir = await videosDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearAudios() async {
    final dir = await audiosDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearImages() async {
    final dir = await imagesDir;
    await _clearDirContents(dir);
  }

  static Future<void> clearAll() async {
    await Future.wait([
      clearVideos(),
      clearAudios(),
      clearImages(),
    ]);
  }
}