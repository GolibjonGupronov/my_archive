import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/constants/colors.dart';
import 'package:my_archive/core/extensions/number.dart';
import 'package:my_archive/core/theme/app_theme.dart';
import 'package:my_archive/core/widgets/custom_text_field.dart';

class SingleSelectItemModel {
  final String title;
  final dynamic value;
  final List<String> extraVisibleValues;

  SingleSelectItemModel(this.title, this.value, {this.extraVisibleValues = const []});
}

class SingleSelectListPage extends StatefulWidget {
  final List<SingleSelectItemModel> items;
  final dynamic selectedItem;
  final Function(dynamic item) onSelect;
  final ScrollController scrollController;

  const SingleSelectListPage(
      {super.key, required this.items, required this.selectedItem, required this.onSelect, required this.scrollController});

  @override
  State<SingleSelectListPage> createState() => _SingleSelectListPageState();
}

class _SingleSelectListPageState extends State<SingleSelectListPage> {
  late dynamic _selectedItem;
  List<SingleSelectItemModel> lists = [];
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
          Text(_searchController.text.isEmpty ? "Ro'yxatdan toping" : "* Qidiruv natijalari",
              style: AppTheme.textTheme.titleLarge!.copyWith(color: AppColors.black)),
          12.height,
          Expanded(
            child: lists.isEmpty
                ? ListView(
                    controller: widget.scrollController,
                    children: [
                      12.height,
                      Icon(CupertinoIcons.exclamationmark_circle, size: 30.w, color: AppColors.orange),
                      4.height,
                      Text("Topilmadi",
                          textAlign: TextAlign.center,
                          style: AppTheme.textTheme.headlineSmall!.copyWith(color: AppColors.orange)),
                    ],
                  )
                : ListView.builder(
                    controller: widget.scrollController,
                    itemBuilder: (_, position) {
                      final item = lists[position];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.r),
                          onTap: () {
                            widget.onSelect(item.value);
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                    color: item.value == _selectedItem ? AppColors.green.withValues(alpha: .5) : AppColors.gray)),
                            padding: EdgeInsets.all(14.w),
                            child: Row(
                              children: [
                                Icon(
                                  item.value == _selectedItem ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked,
                                  color: item.value == _selectedItem ? AppColors.green : AppColors.gray,
                                ),
                                8.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(item.title, style: AppTheme.textTheme.headlineMedium?.copyWith(color: Colors.black)),
                                      ...item.extraVisibleValues.map((e) => Text(e)),
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
