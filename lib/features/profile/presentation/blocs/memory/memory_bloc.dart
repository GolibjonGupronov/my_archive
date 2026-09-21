import 'package:bloc/bloc.dart';
import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:my_archive/core/enums/common.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/services/path_service.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_event.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(MemoryState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(sizeStatus: StateStatus.inProgress));
      double videosBytes = await PathService.videosBytes;
      double audiosBytes = await PathService.audiosBytes;
      double imagesBytes = await PathService.imagesBytes;
      double filesBytes = await PathService.filesBytes;

      final folderTotalSize = videosBytes + audiosBytes + imagesBytes;

      final totalSpace = (await DiskSpacePlus().getTotalDiskSpace) ?? 0.0;
      final freeSpace = (await DiskSpacePlus().getFreeDiskSpace) ?? 0.0;

      Map<FolderType, double> folderBytes = {
        FolderType.video: videosBytes,
        FolderType.audio: audiosBytes,
        FolderType.image: imagesBytes,
        FolderType.file: filesBytes,
      };

      Map<FolderType, double> folderPercent = {
        FolderType.video: folderTotalSize == 0.0 ? 0.0 : videosBytes / folderTotalSize * 100,
        FolderType.audio: folderTotalSize == 0.0 ? 0.0 : audiosBytes / folderTotalSize * 100,
        FolderType.image: folderTotalSize == 0.0 ? 0.0 : imagesBytes / folderTotalSize * 100,
        FolderType.file: folderTotalSize == 0.0 ? 0.0 : filesBytes / folderTotalSize * 100,
      };

      emit(state.copyWith(
        sizeStatus: StateStatus.success,
        totalDiskSpace: totalSpace,
        freeDiskSpace: freeSpace,
        folderTotalSize: folderTotalSize,
        folderBytes: folderBytes,
        folderPercent: folderPercent,
      ));
    });

    on<ClearFolderEvent>((event, emit) async {
      emit(state.copyWith(sizeStatus: StateStatus.inProgress));
      await PathService.clearAll();
      emit(state.copyWith(
        sizeStatus: StateStatus.success,
        folderTotalSize: 0.0,
        folderBytes: {},
        folderPercent: {},
      ));
    });
  }
}
