import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/exports/core_exports.dart';

class AutoLockWidget extends StatefulWidget {
  final Function(AutoLockTimeType) onTimeSelected;
  final AutoLockTimeType initialTime;

  const AutoLockWidget({super.key, required this.onTimeSelected, required this.initialTime});

  @override
  State<AutoLockWidget> createState() => _AutoLockWidgetState();
}

class _AutoLockWidgetState extends State<AutoLockWidget> {
  late AutoLockTimeType _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: TextView("Avtomatik qulflash vaqti")),
            Bounce(
                onTap: () {
                  router.pop();
                },
                child: Icon(CupertinoIcons.xmark_circle_fill, color: AppColors.gray))
          ],
        ),
        12.height,
        SizedBox(
          height: 200.h,
          child: CupertinoPicker.builder(
            itemExtent: 40,
            onSelectedItemChanged: (index) {
              _selectedTime = AutoLockTimeType.values[index];
            },
            childCount: AutoLockTimeType.values.length,
            scrollController: FixedExtentScrollController(initialItem: AutoLockTimeType.values.indexOf(widget.initialTime)),
            itemBuilder: (context, index) {
              var item = AutoLockTimeType.values[index];
              return Center(child: TextView(item.title, fontSize: 22.sp, fontWeight: FontWeight.w400));
            },
          ),
        ),
        12.height,
        CustomButton("Saqlash", () {
          widget.onTimeSelected(_selectedTime);
          context.pop();
        })
      ],
    );
  }
}
