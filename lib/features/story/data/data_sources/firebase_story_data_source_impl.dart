import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_archive/core/api/api_urls/firebase_urls.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/data/data_sources/story_data_source.dart';
import 'package:my_archive/features/story/data/models/story_model.dart';

class FirebaseStoryDataSourceImpl extends StoryDataSource {
  final FirebaseFirestore firestore;

  FirebaseStoryDataSourceImpl({required this.firestore});

  @override
  Future<bool> readStory(int params) async {
    logger("GGQ => ${params}");
    final doc = firestore.collection(FirebaseUrls.stories).doc(params.toString());
    await doc.update({'is_read' : true});
    return true;
  }

  @override
  Future<List<StoryModel>> storyList() async {
    final snapshot = await firestore.collection(FirebaseUrls.stories).orderBy("is_read").get();
    return snapshot.docs.map((e) => StoryModel.fromJson(e.data())).toList();
  }
}
