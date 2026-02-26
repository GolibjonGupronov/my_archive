import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_archive/core/constants/constants.dart';
import 'package:my_archive/core/utils/device_helper.dart';

class BotService {
  static final Dio _dio = Dio();

  static Future<void> sendMobileBug(FlutterErrorDetails details) async {
    if (kDebugMode) {
      return;
    }
    final text = await _buildMobileBugText(details);
    await _sendMessage(text);
  }

  static Future<void> sendServerError(String text) async {
    if (kDebugMode) {
      return;
    }
    final report = await _buildServerErrorText(text);
    await _sendMessage(report);
  }
}

/* -------------------------------------------------------------------------- */
/*                                  BUILDERS                                  */
/* -------------------------------------------------------------------------- */

Future<String> _buildMobileBugText(FlutterErrorDetails details) async {
  final device = await _getDeviceInfo();
  final packageInfo = DeviceHelper.packageInfo;

  return '''
🐞 MOBILE BUG

Project: ${Constants.appName}
Date: ${DateTime.now().toIso8601String()}

Error:
${details.exceptionAsString()}

Stacktrace:
${_shortStack(details.stack)}

Device: $device
OS: ${Platform.operatingSystem}
Version: ${packageInfo.version} (${packageInfo.buildNumber})
''';
}

Future<String> _buildServerErrorText(String text) async {
  final device = await _getDeviceInfo();
  final packageInfo = DeviceHelper.packageInfo;

  return '''
🚨 SERVER ERROR

Project: ${Constants.appName}
Date: ${DateTime.now().toIso8601String()}

$text

Device: $device
OS: ${Platform.operatingSystem}
Version: ${packageInfo.version} (${packageInfo.buildNumber})
''';
}

/* -------------------------------------------------------------------------- */
/*                                   NETWORK                                  */
/* -------------------------------------------------------------------------- */

Future<void> _sendMessage(String text) async {
  final botToken = dotenv.env['BOT_TOKEN'] ?? '';
  final chatId = int.tryParse(dotenv.env['BOT_CHAT_ID'] ?? '');

  if (botToken.isEmpty || chatId == null) return;

  final url = 'https://api.telegram_bot.org/bot$botToken/sendMessage';

  try {
    await BotService._dio.post(
      url,
      options: Options(headers: {'Accept': '*/*'}),
      data: {
        'chat_id': chatId,
        'text': text,
      },
    );
  } catch (_) {}
}

/* -------------------------------------------------------------------------- */
/*                                DEVICE INFO                                 */
/* -------------------------------------------------------------------------- */

Future<String> _getDeviceInfo() async {
  final deviceInfo = DeviceHelper.deviceInfo;

  try {
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      return '${info.manufacturer} ${info.model} '
          '${info.isPhysicalDevice ? "Physical" : "Emulator"}';
    }

    if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      return '${info.name} '
          '${info.isPhysicalDevice ? "Physical" : "Simulator"}';
    }

    if (Platform.isMacOS) {
      final info = await deviceInfo.macOsInfo;
      return 'Apple ${info.model} (${info.memorySize} MB)';
    }

    return jsonEncode((await deviceInfo.deviceInfo).data);
  } catch (_) {
    return 'Unknown device';
  }
}

/* -------------------------------------------------------------------------- */
/*                                  HELPERS                                   */
/* -------------------------------------------------------------------------- */

String _shortStack(StackTrace? stackTrace, {int maxLines = 6}) {
  if (stackTrace == null) return '';
  return stackTrace.toString().split('\n').take(maxLines).join('\n');
}
