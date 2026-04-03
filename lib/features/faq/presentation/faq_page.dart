import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/faq/presentation/bloc/faq_bloc.dart';
import 'package:my_archive/features/faq/presentation/bloc/faq_event.dart';
import 'package:my_archive/features/faq/presentation/bloc/faq_state.dart';
import 'package:my_archive/features/faq/presentation/widgets/faq_item.dart';
import 'package:my_archive/features/faq/presentation/widgets/faq_shimmer_item.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  static const String tag = '/faq_page';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FaqBloc(faqUseCase: sl())..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<FaqBloc>(context);

    return BlocListener<FaqBloc, FaqState>(
      listenWhen: (p, c) => p.faqStatus != c.faqStatus,
      listener: (context, state) {
        if (state.faqStatus.isFailure) {
          showErrorDialog(context, title: state.errorMessage);
        }
      },
      child: CustomScaffold(
        appBar: CustomAppBar("FAQ"),
        body: BlocBuilder<FaqBloc, FaqState>(
          builder: (context, state) {
            final progress = state.faqStatus.isInProgress;
            return canShowEmpty(state.faqList, progress)
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.question_mark_rounded, size: 64.w),
                        SizedBox(height: 16.h),
                        TextView("Savollar topilmadi", fontSize: 16.sp, color: Colors.grey),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    itemBuilder: (context, index) {
                      if (progress) return FaqShimmerItem();
                      final item = state.faqList[index];
                      return FaqItem(item: item);
                    },
                    separatorBuilder: (context, index) => 10.height,
                    itemCount: progress ? 3 : state.faqList.length,
                  );
          },
        ),
      ),
    );
  }
}
