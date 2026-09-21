import 'package:bloc/bloc.dart';
import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:my_archive/core/enums/state_status.dart';
import 'package:my_archive/core/services/path_service.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_event.dart';
import 'package:my_archive/features/profile/presentation/blocs/memory/memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(MemoryState()) {
    on<InitEvent>((event, emit) async {
      emit(state.copyWith(sizeStatus: StateStatus.inProgress));
      final videosMb = (await PathService.videosBytes) / 1024 / 1024;
      final audiosMb = (await PathService.audiosBytes) / 1024 / 1024;
      final imagesMb = (await PathService.imagesBytes) / 1024 / 1024;

      final folderMbSize = videosMb + audiosMb + imagesMb;

      final totalSpace = (await DiskSpacePlus().getTotalDiskSpace) ?? 0.0;
      final freeSpace = (await DiskSpacePlus().getFreeDiskSpace) ?? 0.0;

      emit(state.copyWith(
        sizeStatus: StateStatus.success,
        totalDiskSpace: totalSpace,
        freeDiskSpace: freeSpace,
        folderMbSize: folderMbSize,
        videosMb: videosMb,
        videosPercent: folderMbSize == 0.0 ? 0.0 : videosMb / folderMbSize * 100,
        audiosMb: audiosMb,
        audiosPercent: folderMbSize == 0.0 ? 0.0 : audiosMb / folderMbSize * 100,
        imagesMb: imagesMb,
        imagesPercent: folderMbSize == 0.0 ? 0.0 : imagesMb / folderMbSize * 100,
      ));
    });

    on<ClearFolderEvent>((event, emit) async {
      emit(state.copyWith(sizeStatus: StateStatus.inProgress));
      await PathService.clearAll();
      emit(state.copyWith(
        sizeStatus: StateStatus.success,
        folderMbSize: 0.0,
        videosMb: 0.0,
        videosPercent: 0.0,
        audiosMb: 0.0,
        audiosPercent: 0.0,
        imagesMb: 0.0,
        imagesPercent: 0.0,
      ));
    });
  }
}
