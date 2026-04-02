import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';

class SingleSelectItemEntity {
  final String title;
  final dynamic value;
  final List<String> extraVisibleValues;

  SingleSelectItemEntity(this.title, this.value, {this.extraVisibleValues = const []});
}

class SingleSelectListWidget extends StatefulWidget {
  final List<SingleSelectItemEntity> items;
  final dynamic selectedItem;
  final Function(dynamic item) onSelect;
  final ScrollController scrollController;

  const SingleSelectListWidget(
      {super.key, required this.items, required this.selectedItem, required this.onSelect, required this.scrollController});

  @override
  State<SingleSelectListWidget> createState() => _SingleSelectListWidgetState();
}

class _SingleSelectListWidgetState extends State<SingleSelectListWidget> {
  late dynamic _selectedItem;
  List<SingleSelectItemEntity> lists = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lists = widget.items;
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField("", hint: "Qidiruv", controller: _searchController, onChanged: (value) {
            setState(() {
              lists = widget.items.where((e) => e.title.toLowerCase().contains(value.toLowerCase())).toList();
            });
          }),
          12.height,
          TextView(_searchController.text.isEmpty ? "Ro'yxatdan toping" : "Qidiruv natijalari"),
          12.height,
          Expanded(
            child: lists.isEmpty
                ? ListView(
                    controller: widget.scrollController,
                    children: [
                      12.height,
                      Icon(CupertinoIcons.exclamationmark_circle, size: 30.w, color: AppColors.orange),
                      4.height,
                      TextView("Topilmadi", color: AppColors.orange, textAlign: TextAlign.center),
                    ],
                  )
                : ListView.builder(
                    controller: widget.scrollController,
                    itemBuilder: (_, position) {
                      final item = lists[position];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Bounce(
                          onTap: () {
                            widget.onSelect(item.value);
                            Navigator.pop(context);
                          },
                          child: BoxContainer(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                                color: item.value == _selectedItem
                                    ? AppColors.primary.withValues(alpha: .5)
                                    : (context.isDarkModeEnable ? AppColors.gray : AppColors.lightGray)),
                            padding: EdgeInsets.all(18.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      TextView(item.title),
                                      ...item.extraVisibleValues.map((e) => TextView(e)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    primary: false,
                    itemCount: lists.length,
                    padding: EdgeInsets.zero,
                  ),
          ),
        ],
      ),
    );
  }
}
