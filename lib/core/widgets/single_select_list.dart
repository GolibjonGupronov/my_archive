import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ishonch_geo/presentation/assets/asset_index.dart';
import 'package:ishonch_geo/presentation/components/input/text_input.dart';

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

  const SingleSelectListPage({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelect,
    required this.scrollController
  });

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
          TextInputWidget(hint: "Qidiruv", controller: _searchController, suffixIcon: AppIcons.search,onChanged: (value){
            setState(() {
              lists = widget.items.where((e)=>e.title.toLowerCase().contains(value.toLowerCase())).toList();
            });
          }),
          Gap(ScreenSize.h12),
          Text(_searchController.text.isEmpty?"Ro'yxatdan toping":"* Qidiruv natijalari",
            style: AppTheme.data.textTheme.titleLarge!.copyWith(color: AppTheme.colors.black)),
          Gap(ScreenSize.h12),
          Expanded(
            child: lists.isEmpty?
                ListView(
                  controller: widget.scrollController,
                  children: [
                    Gap(ScreenSize.h12),
                    Icon(CupertinoIcons.exclamationmark_circle,size: ScreenSize.w30, color: AppTheme.colors.infoToast),
                    Gap(ScreenSize.h4),
                    Text("Topilmadi",
                        textAlign: TextAlign.center,
                        style: AppTheme.data.textTheme.headlineSmall!.copyWith(color: AppTheme.colors.infoToast)),
                  ],
                ):
            ListView.builder(
              controller: widget.scrollController,
              itemBuilder: (_, position) {
                final item = lists[position];
                return Padding(
                  padding:  EdgeInsets.only(bottom: ScreenSize.h8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular( ScreenSize.r16),
                    onTap: () {
                      widget.onSelect(item.value);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( ScreenSize.r16),
                      border: Border.all(color: item.value == _selectedItem ? AppTheme.colors.green.withValues(alpha: .5):AppTheme.colors.lineColor)),
                      padding: EdgeInsets.all( ScreenSize.w14),
                      child: Row(
                        children: [
                          Icon(
                            item.value == _selectedItem ? Icons.radio_button_checked_rounded : Icons.radio_button_unchecked,
                            color: item.value == _selectedItem ?  AppTheme.colors.green :  AppTheme.colors.grey,
                          ),
                      Gap(ScreenSize.w8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(item.title,style: AppTheme.data.textTheme.headlineMedium?.copyWith(color: Colors.black)),
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