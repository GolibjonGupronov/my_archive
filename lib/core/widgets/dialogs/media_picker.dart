import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_archive/core/app_router/route_exports.dart';
import 'package:my_archive/core/core_exports.dart';

class MediaPicker {
  static Future<void> showFilePicker({
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
                      if (!await PermissionService.requestCameraPermissionWithToast(ctx)) {
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
                      if (!await PermissionService.requestGalleryPermissionWithToast(ctx)) {
                        return;
                      }
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
                      if (!await PermissionService.requestFilePermissionWithToast(ctx)) {
                        return;
                      }
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

  static Future<void> showImagePicker({
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
                      if (!await PermissionService.requestCameraPermissionWithToast(ctx)) {
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
                      if (!await PermissionService.requestGalleryPermissionWithToast(ctx)) {
                        return;
                      }
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
