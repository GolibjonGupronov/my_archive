import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/core_exports.dart';

class NoImagePage extends StatelessWidget {
  const NoImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Center(child: TextView('Rasm mavjud emas')),
          Positioned(
            top: context.safeTop(20),
            left: 16.w,
            child: Bounce(
              onTap: () {
                context.pop();
              },
              child: BoxContainer(
                shape: BoxShape.circle,
                padding: EdgeInsets.all(10.w),
                child: Icon(CupertinoIcons.chevron_back, size: 18.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
