import 'package:my_archive/core/enums/state_status.dart';

class MemoryState {
  final StateStatus sizeStatus;
  final double totalDiskSpace;
  final double freeDiskSpace;
  final double folderMbSize;
  final double videosMb;
  final double videosPercent;
  final double imagesMb;
  final double imagesPercent;
  final double audiosMb;
  final double audiosPercent;

  MemoryState({
    this.sizeStatus = StateStatus.initial,
    this.totalDiskSpace = 0.0,
    this.freeDiskSpace = 0.0,
    this.folderMbSize = 0.0,
    this.videosMb = 0.0,
    this.videosPercent = 0.0,
    this.imagesMb = 0.0,
    this.imagesPercent = 0.0,
    this.audiosMb = 0.0,
    this.audiosPercent = 0.0,
  });

  MemoryState copyWith({
    StateStatus? sizeStatus,
    double? totalDiskSpace,
    double? freeDiskSpace,
    double? folderMbSize,
    double? videosMb,
    double? videosPercent,
    double? imagesMb,
    double? imagesPercent,
    double? audiosMb,
    double? audiosPercent,
  }) {
    return MemoryState(
      sizeStatus: sizeStatus ?? this.sizeStatus,
      totalDiskSpace: totalDiskSpace ?? this.totalDiskSpace,
      freeDiskSpace: freeDiskSpace ?? this.freeDiskSpace,
      folderMbSize: folderMbSize ?? this.folderMbSize,
      videosMb: videosMb ?? this.videosMb,
      videosPercent: videosPercent ?? this.videosPercent,
      imagesMb: imagesMb ?? this.imagesMb,
      imagesPercent: imagesPercent ?? this.imagesPercent,
      audiosMb: audiosMb ?? this.audiosMb,
      audiosPercent: audiosPercent ?? this.audiosPercent,
    );
  }
}
