import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import '../domain/services/video_feed_service.dart';

class VideoFeedRepliesProvider extends ChangeNotifier {
  late List<VideoFeedModel> _videoFeedList;

  final notification = getIt<NotificationProvider>();

  final _service = ViedoFeedService(dio: getIt<Dio>());

  bool _loading = false;
  bool get loading => _loading;
  List<VideoFeedModel> get videoFeedList => _videoFeedList;

  Future<void> fetchVideoFeedReplies({required int videoId}) async {
    log('init');
    _loading = true;
    notifyListeners();

    try {
      final videoFeedList = await _service.fetchVideoFeedReplies(
          videoId: videoId, page: 1, pageSize: 5);

      _videoFeedList = videoFeedList;
    } catch (e) {
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
