import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_archive/core/core_exports.dart';

enum AutoLockTimeType {
  immediately,
  after5Seconds,
  after10Seconds,
  after30Seconds,
  after1Minute,
  after5Minutes,
  after10Minutes,
  after30Minutes,
  after1Hour,
  disable;

  static AutoLockTimeType getObj(String key) => AutoLockTimeType.values.firstWhere((e) => e.name == key);

  String get key => name;

  String get title => switch (this) {
        AutoLockTimeType.immediately => "Darhol",
        AutoLockTimeType.after5Seconds => "5 soniya",
        AutoLockTimeType.after10Seconds => "10 soniya",
        AutoLockTimeType.after30Seconds => "30 soniya",
        AutoLockTimeType.after1Minute => "1 minut",
        AutoLockTimeType.after5Minutes => "5 minut",
        AutoLockTimeType.after10Minutes => "10 minut",
        AutoLockTimeType.after30Minutes => "30 minut",
        AutoLockTimeType.after1Hour => "1 soat",
        AutoLockTimeType.disable => "O'chiq",
      };

  int get seconds => switch (this) {
        AutoLockTimeType.immediately => 0,
        AutoLockTimeType.after5Seconds => 5,
        AutoLockTimeType.after10Seconds => 10,
        AutoLockTimeType.after30Seconds => 30,
        AutoLockTimeType.after1Minute => 60,
        AutoLockTimeType.after5Minutes => 5 * 60,
        AutoLockTimeType.after10Minutes => 10 * 60,
        AutoLockTimeType.after30Minutes => 30 * 60,
        AutoLockTimeType.after1Hour => 60 * 60,
        AutoLockTimeType.disable => -1,
      };
}

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
