import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/core/api/firebase_interceptor.dart';
import 'package:my_archive/features/faq/data/data_source/faq_data_source.dart';
import 'package:my_archive/features/faq/data/models/faq_model.dart';

class FirebaseFaqDataSourceImpl extends FaqDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAliceLogger logger;

  FirebaseFaqDataSourceImpl({required this.firestore, required this.logger});

  @override
  Future<List<FaqModel>> faqList() async {
    return await logger.logCall(
      methodName: "FirebaseUrls.faqList",
      requestBody: {},
      action: () async {
        final snapshot = await firestore.collection(FirebaseUrls.faqList).get();
        return snapshot.docs.map((e) => FaqModel.fromJson(e.data())).toList();
      },
    );
  }
}
