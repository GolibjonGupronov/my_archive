import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_archive/core/core_exports.dart';

Future<void> showDraggableBottomSheet({
  required BuildContext context,
  required Widget Function(ScrollController controller) childBuilder,
  String title = "",
}) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => Material(
      color: context.isDarkModeEnable ? AppColors.scaffoldDarkBackground : AppColors.white,
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListView(
                shrinkWrap: true,
                controller: scrollController,
                children: [
                  Center(
                      child: Container(
                          width: 50.w,
                          height: 4.h,
                          margin: EdgeInsets.only(top: 6.h),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r), color: AppColors.gray))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      children: [
                        Expanded(child: Text(title, style: AppTheme.textTheme.displayLarge)),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.lightGray),
                            child: Icon(CupertinoIcons.xmark, size: 14.w, color: AppColors.gray),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              8.height,
              Flexible(child: childBuilder(scrollController))
            ],
          );
        },
      ),
    ),
  );
}

Future<void> showCustomBottomSheetDialog({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
}) {
  return showCustomModalBottomSheet(
    context: context,
    isDismissible: isDismissible,
    builder: (context) => PopScope(
      canPop: isDismissible,
      child: child,
    ),
    containerWidget: (context, animation, child) => Material(
      color: context.isDarkModeEnable ? AppColors.whiteDark : AppColors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          4.height,
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.all(8.w),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.r), color: AppColors.gray),
            ),
          ),
          2.height,
          Container(
            constraints: BoxConstraints(maxHeight: context.screenHeight * .8),
            child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              children: [child],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> showCustomSingleDatePicker(
  BuildContext context, {
  DateTime? initialDate,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime time) result,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => CustomCalendarView.single(
      initialStart: initialDate ?? DateTime.now(),
      minimumDate: minimumDate,
      onApply: (dateTime) {
        result(dateTime);
      },
    ),
  );
}

Future<void> showCustomRangeDatePicker(
  BuildContext context, {
  DateTime? initialStart,
  DateTime? initialEnd,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime fromTime, DateTime toTime) result,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (context) => CustomCalendarView.range(
      initialStart: initialStart,
      initialEnd: initialEnd,
      minimumDate: minimumDate,
      onApply: (fromTime, toTime) {
        result(fromTime, toTime);
      },
    ),
  );
}

Future<void> showCustomTimePicker(
  BuildContext context, {
  DateTime? initialTime,
  DateTime? minimumDate,
  bool barrierDismissible = true,
  required Function(DateTime time) result,
}) async {
  DateTime dateTime = initialTime ?? DateTime.now();
  await showCustomBottomSheetDialog(
    context: context,
    isDismissible: barrierDismissible,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        14.height,
        TextView(tr('choose_time'), fontSize: 24.sp),
        14.height,
        SizedBox(
          height: 180.h,
          child: CupertinoDatePicker(
            initialDateTime: dateTime,
            onDateTimeChanged: (time) {
              dateTime = time;
            },
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            showTimeSeparator: true,
          ),
        ),
        18.height,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomButton(
            tr('save'),
            () {
              result(dateTime);
              Navigator.pop(context);
            },
          ),
        ),
        16.height,
      ],
    ),
  );
}

Future<void> showFilePicker({
  required BuildContext ctx,
  required Function(String path) onResult,
  CropAspectRatioPreset initAspectRatio = CropAspectRatioPreset.original,
}) async {
  return showCupertinoModalPopup(
      context: ctx,
      builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    router.pop();
                    if (!await HandlePermission.cameraIsGranted) {
                      showErrorToast(ctx, tr('allow_access_camera'));
                      return;
                    }
                    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 60);
                    // if (pickedImage != null) {
                    //   if ((await pickedImage.length()) > 1024 * 1024 * 8) {
                    //     showErrorToast(ctx, tr('max_image_size'.plural(8)));
                    //   } else {
                    //     onResult(pickedImage.path);
                    //   }
                    // }
                    if (pickedImage != null) {
                      if (initAspectRatio == CropAspectRatioPreset.original) {
                        onResult(pickedImage.path);
                      } else {
                        _cropImage(
                            imagePath: pickedImage.path,
                            initAspectRatio: initAspectRatio,
                            result: (String path) {
                              onResult(path);
                            });
                      }
                    }
                  },
                  child: TextView(tr('camera'))),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    router.pop();
                    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      if (initAspectRatio == CropAspectRatioPreset.original) {
                        onResult(pickedImage.path);
                      } else {
                        _cropImage(
                            imagePath: pickedImage.path,
                            initAspectRatio: initAspectRatio,
                            result: (String path) {
                              onResult(path);
                            });
                      }
                    }
                  },
                  child: TextView(tr('gallery'))),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    router.pop();
                    final files = await FilePicker.platform.pickFiles(
                      // allowCompression: true,
                      allowMultiple: false,
                    );
                    if (files != null && files.files.isNotEmpty) {
                      final List<String> filePath = [];
                      final List<String> fileNames = [];
                      final List<int> fileSizes = [];
                      for (var file in files.files) {
                        if (file.path != null) {
                          filePath.add(file.path!);
                          fileNames.add(file.name);
                          fileSizes.add(file.size);
                        }
                      }

                      if (filePath.isNotEmpty) {
                        onResult(filePath.first);
                      } else {
                        showErrorToast(ctx, tr('file_not_found'));
                      }
                    }
                  },
                  child: TextView(tr('file'))),
            ],
            cancelButton:
                CupertinoActionSheetAction(onPressed: () => context.pop(), child: TextView(tr('cancel'), color: AppColors.red)),
          ));
}

Future<void> showImagePicker({
  required BuildContext ctx,
  required Function(String path) onResult,
  CropAspectRatioPreset initAspectRatio = CropAspectRatioPreset.original,
}) async {
  return showCupertinoModalPopup(
      context: ctx,
      builder: (context) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                  onPressed: () async {
                    router.pop();
                    if (!await HandlePermission.cameraIsGranted) {
                      showErrorToast(ctx, tr('allow_access_camera'));
                      return;
                    }
                    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 60);
                    // if (pickedImage != null) {
                    //   if ((await pickedImage.length()) > 1024 * 1024 * 8) {
                    //     showErrorToast(ctx, tr('max_image_size'.plural(8)));
                    //   } else {
                    //     onResult(pickedImage.path);
                    //   }
                    // }
                    if (pickedImage != null) {
                      if (initAspectRatio == CropAspectRatioPreset.original) {
                        onResult(pickedImage.path);
                      } else {
                        _cropImage(
                            imagePath: pickedImage.path,
                            initAspectRatio: initAspectRatio,
                            result: (String path) {
                              onResult(path);
                            });
                      }
                    }
                  },
                  child: TextView(tr('camera'))),
              CupertinoActionSheetAction(
                  onPressed: () async {
                    router.pop();
                    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      if (initAspectRatio == CropAspectRatioPreset.original) {
                        onResult(pickedImage.path);
                      } else {
                        _cropImage(
                            imagePath: pickedImage.path,
                            initAspectRatio: initAspectRatio,
                            result: (String path) {
                              onResult(path);
                            });
                      }
                    }
                  },
                  child: TextView(tr('gallery'))),
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  context.pop();
                },
                child: TextView(tr('cancel'), color: AppColors.red)),
          ));
}

Future<void> _cropImage({
  required String imagePath,
  required CropAspectRatioPreset initAspectRatio,
  required Function(String path) result,
}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imagePath,
    aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Rasmni qirqish',
        initAspectRatio: initAspectRatio,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: 'Rasmni qirqish',
        aspectRatioLockEnabled: true,
      ),
    ],
  );

  if (croppedFile != null) {
    result(croppedFile.path);
  }
}
