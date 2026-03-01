import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:my_archive/features/profile/presentation/bloc/profile_event.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);

    return CustomScaffold(
      appBar: CustomAppBar(tr('profile')),
      body: ListView(
        children: [
          Center(
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Stack(
                children: [
                  Bounce(
                    onTap: (){
                      router.push(ImageZoomPage.tag, extra: ["https://picsum.photos/400/200?3"]);
                    },
                    child: BoxContainer(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Assets.images.logo.image(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Bounce(
                      onTap: () {
                        // showImagePicker(context, (value) {});
                      },
                      child: BoxContainer(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        child: Icon(CupertinoIcons.camera_circle_fill, size: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
