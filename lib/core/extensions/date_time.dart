import 'package:intl/intl.dart';

extension FormattedDateTime on DateTime? {
  String get toBackendDate => this == null ? "" : DateFormat('yyyy-MM-dd').format(this!);

  String get toBackendTime => this == null ? "" : DateFormat('HH:mm').format(this!);

  String get toBackendDateTime => this == null ? "" : DateFormat('yyyy-MM-dd HH:mm').format(this!);

  String get formattedDate => this == null ? "" : DateFormat('dd.MM.yyyy').format(this!);

  String get formattedTime => this == null ? "" : DateFormat('HH:mm').format(this!);

  String get formattedDateTime => this == null ? "" : DateFormat('dd.MM.yyyy HH:mm').format(this!);
}
