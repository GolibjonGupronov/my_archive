import 'package:dio/dio.dart';
import 'package:my_archive/core/api/dio/dio_mock.dart';
import 'package:my_archive/core/exports/data_exports.dart';
import 'package:my_archive/features/story/data/data_sources/story_data_source.dart';
import 'package:my_archive/features/story/data/models/story_model.dart';

class StoryDataSourceImpl extends StoryDataSource {
  final Dio dio;

  StoryDataSourceImpl({required this.dio});

  @override
  Future<List<StoryModel>> storyList() async {
    final response = await dio.mock(data: []).get(ApiUrls.storyList);
    return (response.data as List<dynamic>).map((e) => StoryModel.fromJson(e)).toList();
  }

  @override
  Future<bool> readStory(int params) async {
    final response = await dio.mock(data: true).post(ApiUrls.readStory, data: {"id": params});
    return response.data;
  }
}
