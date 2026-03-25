import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/core/widgets/dialogs/media_picker.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_state.dart';

class ProfileImage extends StatelessWidget {
  final ProfileBloc bloc;

  const ProfileImage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileBloc, ProfileState, ({StateStatus changeImageStatus, String userImage, String fullName})>(
      selector: (state) =>
          (changeImageStatus: state.changeImageStatus, userImage: state.userImage, fullName: state.user?.fullName ?? ""),
      builder: (context, state) {
        return Column(
          children: [
            Center(
              child: SizedBox(
                width: 120.w,
                height: 120.h,
                child: Bounce(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Dialog(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BoxContainer(
                                border: Border.all(width: 2.w, color: AppColors.primary),
                                width: context.screenWidth - 100,
                                height: context.screenWidth - 100,
                                shape: BoxShape.circle,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(context.screenWidth / 2),
                                  child: _AvatarView(
                                    image: state.userImage,
                                    fullName: state.fullName,
                                    onCameraTap: () {
                                      if (state.changeImageStatus.isInProgress) return;

                                      MediaPicker.showImagePicker(
                                        ctx: context,
                                        onResult: (result) {
                                          bloc.add(ChangeImageEvent(path: result));
                                          router.pop();
                                        },
                                        initAspectRatio: CropAspectRatioPreset.square,
                                      );
                                    },
                                    isLarge: true,
                                  ),
                                ),
                              ),
                              24.height,
                              if (state.userImage.isNotEmpty)
                                Bounce(
                                  onTap: () {
                                    showRejectDialog(
                                      context,
                                      "Rasmni o'chirmoqchimisiz",
                                      onConfirm: () {
                                        bloc.add(ChangeImageEvent(path: ""));
                                        router.pop();
                                      },
                                      type: MyDialogType.warning,
                                    );
                                  },
                                  child: BoxContainer(
                                    padding: EdgeInsets.all(6.w),
                                    border: Border.all(color: AppColors.white),
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                    child: Icon(CupertinoIcons.trash, color: AppColors.white),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: BoxContainer(
                    shape: BoxShape.circle,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70.r),
                      child: _AvatarView(
                        image: state.userImage,
                        fullName: state.fullName,
                        onCameraTap: () {
                          if (state.changeImageStatus.isInProgress) return;

                          MediaPicker.showImagePicker(
                            ctx: context,
                            onResult: (result) {
                              bloc.add(ChangeImageEvent(path: result));
                            },
                            initAspectRatio: CropAspectRatioPreset.square,
                          );
                        },
                        isLarge: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            8.height,
            TextView(state.fullName, style: AppTheme.textTheme.displayLarge, textAlign: TextAlign.center)
          ],
        );
      },
    );
  }
}

class _AvatarView extends StatelessWidget {
  final String image;
  final String fullName;
  final VoidCallback onCameraTap;
  final bool isLarge;

  const _AvatarView({required this.image, required this.fullName, required this.onCameraTap, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image.isEmpty
            ? BoxContainer(
                color: AppColors.primary,
                child: Center(
                  child: TextView(
                    fullName.getFirstLetters,
                    fontSize: (isLarge ? 60 : 30).sp,
                    color: AppColors.white,
                  ),
                ),
              )
            : CustomImageView(pathOrUrl: image),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: InkWell(
            onTap: onCameraTap,
            child: BoxContainer(
              padding: EdgeInsets.symmetric(vertical: (isLarge ? 14 : 4).h),
              color: AppColors.gray.withValues(alpha: .8),
              child: Icon(CupertinoIcons.photo_camera, size: (isLarge ? 30 : 22).w, color: AppColors.white),
            ),
          ),
        )
      ],
    );
  }
}
