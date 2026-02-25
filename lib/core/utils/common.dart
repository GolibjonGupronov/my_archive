import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> openUrl(String url, {LaunchMode mode = LaunchMode.externalApplication}) async =>
    await launchUrl(Uri.parse(url), mode: mode);

Future<bool?> callNumber(String phone) async => await launchUrl(Uri(scheme: 'tel', path: phone));

MaskTextInputFormatter phoneNumberMask({String mask = '+998 (##) ### ## ##'}) =>
    MaskTextInputFormatter(mask: mask, filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
