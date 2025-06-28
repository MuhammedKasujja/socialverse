import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import '../domain/services/video_feed_service.dart';

class VideoFeedRepliesProvider extends ChangeNotifier {
  final Map<String, List<VideoFeedModel>> _videoRepliesList = {};
  final notification = getIt<NotificationProvider>();

  final _service = ViedoFeedService(dio: getIt<Dio>());

  bool _loading = false;
  bool get loading => _loading;

  Future<void> fetchVideoFeedReplies({required int videoId}) async {
    _loading = true;
    notifyListeners();

    try {
      final videoReplies = await _service.fetchVideoFeedReplies(
        videoId: videoId,
        page: 1,
        pageSize: 5,
      );

      _videoRepliesList.addAll({'$videoId': videoReplies});
      notifyListeners();
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
