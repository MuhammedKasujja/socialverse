import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';

class ViedoFeedService {
  late final Dio _dio;

  ViedoFeedService({required Dio dio}) {
    _dio = dio;
  }

  Future<List<VideoFeedModel>> fetchVideoFeed({
    required int page,
    required int pageSize,
  }) async {
    token = prefs?.getString('token');
    try {
      Response response = await _dio.get(
        'https://api.wemotions.app/feed?page=$page&page_size=$pageSize',
        options: Options(headers: {'Flic-Token': token ?? ''}),
      );
      print(response.data);
      print(response.statusCode);
      // if (response.data['status'] == 'success') {
      //   if (response.statusCode == 200 || response.statusCode == 201) {
      //     String jsonString = json.encode(response.data);
      //     final Map<String, dynamic> responseData = json.decode(jsonString);
      //     var userData = responseData;
      //     ProfileModel userProfile = ProfileModel.fromJson(userData);
      //     _user = userProfile;
      //     prefs!.setString("username", user.username);
      //     prefs_username = prefs?.getString('username') ?? '';

      //     _loading = false;
      //     notifyListeners();

      //     navKey.currentState!
      //       ..pop()
      //       ..pop();
      //   }
      // }
      final list =
          (response.data['posts'] as List).map((json) => VideoFeedModel.fromJson(json));
      return list.toList();
    } on DioError catch (e) {
      log('${e.response?.data}');
      print(e.response?.data);

      throw 'Something Went Wrong';
    } catch (error) {
      log('${error}');
      throw 'Something Went Wrong';
    }
  }

  Future<List<VideoFeedModel>> fetchVideoFeedReplies({
    required int videoId,
    int page = 1,
    int pageSize = 5,
  }) async {
    // print('${API.endpoint}${API.profile}/$videoId');
    try {
      Response response = await _dio.get(
        'https://api.wemotions.app/posts/$videoId/replies?page=$page&page_size=$pageSize',
      );
      print(response.data);
      final list =
          (response.data as List).map((json) => VideoFeedModel.fromJson(json));
      return list.toList();
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);

      if (e.response?.statusCode == 404) {
        throw 'Video not found';
      }
      throw 'Something Went Wrong';
    }
  }
}
