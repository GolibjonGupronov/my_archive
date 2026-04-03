import 'package:dio/dio.dart';
import 'package:my_archive/core/core_exports.dart';
import 'package:my_archive/features/story/data/models/story_action_model.dart';
import 'package:my_archive/features/story/data/models/story_model.dart';
import 'package:my_archive/features/story/domain/entities/story_action_entity.dart';
import 'package:my_archive/features/story/domain/entities/story_entity.dart';

abstract class StoryDataSource {
  Future<List<StoryModel>> storyList();

  Future<bool> readStory(int params);
}

class StoryDataSourceImpl extends StoryDataSource {
  final Dio dio;

  StoryDataSourceImpl({required this.dio});

  @override
  Future<List<StoryModel>> storyList() async {
    final response = await dio.mock(data: _storyList).get(ApiUrls.storyList);
    return (response.data as List<dynamic>).map((e) => StoryModel.fromJson(e)).toList();
  }

  @override
  Future<bool> readStory(int params) async {
    final response = await dio.mock(data: true).post(ApiUrls.readStory, data: {"id": params});
    return response.data;
  }
}

List<StoryModel> get _storyList => [
      StoryModel(
        id: 1,
        title: "Yo'g'och",
        thumbnail: "https://cdn.pixabay.com/photo/2025/08/02/11/04/wood-9750452_1280.jpg",
        resourceData: "https://cdn.pixabay.com/photo/2025/08/02/11/04/wood-9750452_1280.jpg",
        resourceType: StoryFileType.image,
        action: null,
        isRead: false,
      ),
      StoryModel(
        id: 2,
        title: "Yo'g'och",
        thumbnail: "https://cdn.pixabay.com/photo/2025/08/02/11/04/wood-9750452_1280.jpg",
        resourceData: "https://cdn.pixabay.com/photo/2025/08/02/11/04/wood-9750452_1280.jpg",
        resourceType: StoryFileType.image,
        action: null,
        isRead: true,
      ),
      StoryModel(
        id: 3,
        title: "Tabiat",
        thumbnail: "https://cdn.pixabay.com/photo/2022/12/16/16/28/drinking-cups-7660115_960_720.jpg",
        resourceData: "https://pixabay.com/videos/download/video-8386_medium.mp4",
        resourceType: StoryFileType.video,
        action: null,
        isRead: false,
      ),
      StoryModel(
        id: 4,
        title: "Telegram",
        thumbnail: "https://cdn.pixabay.com/photo/2018/01/28/10/59/internet-3113279_1280.jpg",
        resourceData: "https://cdn.pixabay.com/video/2022/01/13/104310-665837458_large.mp4",
        resourceType: StoryFileType.video,
        action: StoryActionModel(title: "Telegram", type: StoryActionType.link, actionData: "https://t.me/m0b1leDevel0per"),
        isRead: false,
      ),
      StoryModel(
        id: 5,
        title: "Parol",
        thumbnail: "https://cdn.pixabay.com/photo/2024/10/24/11/39/data-security-9145391_1280.jpg",
        resourceData: "https://cdn.pixabay.com/photo/2024/10/24/11/39/data-security-9145391_1280.jpg",
        resourceType: StoryFileType.image,
        action: null,
        isRead: false,
      ),
    ];
