import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/features/faq/data/data_source/faq_data_source.dart';
import 'package:my_archive/features/faq/data/models/faq_model.dart';

class FirebaseFaqDataSourceImpl extends FaqDataSource {
  final FirebaseFirestore firestore;

  FirebaseFaqDataSourceImpl({required this.firestore});

  @override
  Future<List<FaqModel>> faqList() async {
    final snapshot = await firestore.collection(FirebaseUrls.faqList).get();
    return snapshot.docs.map((e) => FaqModel.fromJson(e.data())).toList();
  }
}
