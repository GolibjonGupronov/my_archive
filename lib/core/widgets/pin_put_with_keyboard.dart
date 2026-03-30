import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/services/local_auth_service.dart';

enum PinKey {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  zero,
  fingerprint,
  backspace,
  none;

  String get key => switch (this) {
        PinKey.one => "1",
        PinKey.two => "2",
        PinKey.three => "3",
        PinKey.four => "4",
        PinKey.five => "5",
        PinKey.six => "6",
        PinKey.seven => "7",
        PinKey.eight => "8",
        PinKey.nine => "9",
        PinKey.zero => "0",
        _ => "",
      };

  static List<PinKey> get topNumbers => [
        PinKey.one,
        PinKey.two,
        PinKey.three,
        PinKey.four,
        PinKey.five,
        PinKey.six,
        PinKey.seven,
        PinKey.eight,
        PinKey.nine,
      ];
}

class PinPutWithKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFingerprint;
  final bool showFingerPrint;

  const PinPutWithKeyboard({
    super.key,
    required this.controller,
    this.maxLength = 6,
    this.obscureText = true,
    this.onChanged,
    this.onFingerprint,
    this.showFingerPrint = false,
  });

  void _handleKeyTap(PinKey key) {
    final text = controller.text;

    if (key == PinKey.backspace) {
      if (text.isNotEmpty) {
        controller.text = text.substring(0, text.length - 1);
      }
    } else if (key == PinKey.fingerprint) {
      onFingerprint?.call();
      return;
    } else {
      if (text.length < maxLength) {
        controller.text = text + key.key;
      }
    }

    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    onChanged?.call(controller.text);
  }

  List<PinKey> get _buildKeyboard {
    final hasBio = LocalAuthService.canUseBiometric && sl.get<PrefManager>().isBiometric == true && showFingerPrint;
    return [
      ...PinKey.topNumbers,
      hasBio ? PinKey.fingerprint : PinKey.none,
      PinKey.zero,
      PinKey.backspace,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final rows = _chunk(_buildKeyboard, 3);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPinPut(
          controller: controller,
          context: context,
          length: maxLength,
          obscureText: obscureText,
          readOnly: true,
          onChanged: onChanged,
          showBorder: false,
        ),
        SizedBox(height: 24.h),
        ...rows.map((row) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: row.map((key) => _buildKey(key)).toList(),
            ),
          );
        }),
      ],
    );
  }

  List<List<T>> _chunk<T>(List<T> list, int size) {
    final result = <List<T>>[];
    for (int i = 0; i < list.length; i += size) {
      result.add(
        list.sublist(i, i + size > list.length ? list.length : i + size),
      );
    }
    return result;
  }

  Widget _buildKey(PinKey key) {
    return InkWell(
      onTap: () => _handleKeyTap(key),
      child: BoxContainer(
        width: 80.w,
        height: 80.w,
        shape: BoxShape.circle,
        child: Center(child: _buildChild(key)),
      ),
    );
  }

  Widget _buildChild(PinKey key) {
    switch (key) {
      case PinKey.fingerprint:
        return Icon(Icons.fingerprint, size: 30.sp);
      case PinKey.backspace:
        return Icon(Icons.backspace_outlined, size: 30.sp);
      default:
        return TextView(
          key.key,
          fontWeight: FontWeight.bold,
          fontSize: 30.sp,
        );
    }
  }
}
