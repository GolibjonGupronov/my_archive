import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/exports/ui_exports.dart';
import 'package:my_archive/core/services/path_service.dart';
import 'package:my_archive/features/media/domain/entities/media_entity.dart';

class MediaAudio extends StatefulWidget {
  final MediaEntity item;

  const MediaAudio({super.key, required this.item});

  @override
  State<MediaAudio> createState() => _MediaAudioState();
}

class _MediaAudioState extends State<MediaAudio> {
  late final PlayerController playerController;

  static const double _waveformSpacing = 5;
  static const double _sideReservedWidth = 110;

  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _preparePlayer());

    playerController.onCurrentDurationChanged.listen((durationMs) {
      final seconds = durationMs ~/ 1000;
      print('Current position: ${seconds}s');
    });
  }

  Future<void> _preparePlayer() async {
    final dir = await PathService.audiosDir;
    final file = File('${dir.path}/audio.mp3');
    if (!(await file.exists())) {
      final audioFile = await rootBundle.load('assets/audios/forest.mp3');
      await file.writeAsBytes(audioFile.buffer.asUint8List());
    }

    if (!mounted) return;

    final waveformWidth = MediaQuery.of(context).size.width - _sideReservedWidth;

    await playerController.preparePlayer(
      path: file.path,
      shouldExtractWaveform: true,
      noOfSamples: const PlayerWaveStyle(spacing: _waveformSpacing).getSamplesForWidth(waveformWidth),
    );
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final waveformWidth = MediaQuery.of(context).size.width - _sideReservedWidth;

    return BoxContainer(
      padding: EdgeInsets.all(12.w),
      borderRadius: BorderRadius.circular(16.r),
      child: Row(
        children: [
          BoxContainer(
            width: 40.w,
            height: 40.h,
            shape: BoxShape.circle,
            color: AppColors.primary,
            child: Icon(CupertinoIcons.volume_up, color: AppColors.white, size: 22.w),
          ),
          12.width,
          AudioFileWaveforms(
            playerController: playerController,
            waveformType: WaveformType.fitWidth,
            size: Size(waveformWidth, 60.h),
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: Colors.grey,
              liveWaveColor: AppColors.primary,
              spacing: _waveformSpacing,
            ),
          ),
        ],
      ),
    );
  }
}