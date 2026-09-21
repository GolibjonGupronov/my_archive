import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';

class MemoryState {
  final StateStatus sizeStatus;
  final double totalDiskSpace;
  final double freeDiskSpace;
  final double folderTotalSize;
  final Map<FolderType, double> folderBytes;
  final Map<FolderType, double> folderPercent;

  MemoryState({
    this.sizeStatus = StateStatus.initial,
    this.totalDiskSpace = 0.0,
    this.freeDiskSpace = 0.0,
    this.folderTotalSize = 0.0,
    this.folderBytes = const {},
    this.folderPercent = const {},
  });

  MemoryState copyWith({
    StateStatus? sizeStatus,
    double? totalDiskSpace,
    double? freeDiskSpace,
    double? folderTotalSize,
    Map<FolderType, double>? folderBytes,
    Map<FolderType, double>? folderPercent,
  }) {
    return MemoryState(
      sizeStatus: sizeStatus ?? this.sizeStatus,
      totalDiskSpace: totalDiskSpace ?? this.totalDiskSpace,
      freeDiskSpace: freeDiskSpace ?? this.freeDiskSpace,
      folderTotalSize: folderTotalSize ?? this.folderTotalSize,
      folderBytes: folderBytes ?? this.folderBytes,
      folderPercent: folderPercent ?? this.folderPercent,
    );
  }
}
