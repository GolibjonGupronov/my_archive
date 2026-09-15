class VideoCompressConfig {
  /// H.264 profili: baseline | main | high
  final String profile;

  /// H.264 level (masalan '4.1'). Yuqori level barcha qurilmalarda
  /// qo'llab-quvvatlanmasligi mumkin.
  final String level;

  /// Uzun tomonning maksimal piksel qiymati (aspect ratio saqlanadi).
  final int maxDimension;

  /// Maksimal frame rate.
  final int fps;

  /// Constant Rate Factor: 0 (lossless) - 51 (eng past sifat). 18-28 optimal.
  final int crf;

  /// ffmpeg preset: ultrafast..veryslow. Tezlik/hajm muvozanati.
  final String preset;

  /// Audio bitreyt, kbps.
  final int audioBitrateKbps;

  const VideoCompressConfig({
    this.profile = 'main',
    this.level = '4.1',
    this.maxDimension = 1080,
    this.fps = 30,
    this.crf = 23,
    this.preset = 'fast',
    this.audioBitrateKbps = 128,
  });

  /// Keng qurilma moslikka mo'ljallangan standart preset (story, feed va h.k.).
  factory VideoCompressConfig.compatible() => const VideoCompressConfig();

  /// Tezroq compress, biroz kattaroq fayl — masalan katta ro'yxatlarda
  /// ko'p videoni tezda tayyorlash kerak bo'lganda.
  factory VideoCompressConfig.fast() => const VideoCompressConfig(
    preset: 'ultrafast',
    crf: 26,
  );

  /// Sifatga ustunlik beruvchi preset — masalan profil/portfolio videolari.
  factory VideoCompressConfig.highQuality() => const VideoCompressConfig(
    maxDimension: 1440,
    crf: 18,
    preset: 'slow',
    audioBitrateKbps: 192,
  );

  /// Trafik tejash uchun eng past hajm (masalan mobil internet, katalog).
  factory VideoCompressConfig.lowData() => const VideoCompressConfig(
    maxDimension: 720,
    crf: 30,
    fps: 24,
    audioBitrateKbps: 96,
  );

  /// Cache faylini boshqa konfiguratsiyadagi natijadan farqlash uchun
  /// deterministik identifikator.
  String get cacheKey => '${profile}_${level}_${maxDimension}_${fps}_${crf}_${preset}_$audioBitrateKbps';

  String toFfmpegVideoFilter() =>
      "scale='min($maxDimension,iw)':'min($maxDimension,ih)':force_original_aspect_ratio=decrease";
}