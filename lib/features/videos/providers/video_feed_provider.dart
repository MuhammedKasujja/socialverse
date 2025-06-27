import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import '../domain/services/video_feed_service.dart';

class VideoFeedProvider extends ChangeNotifier {
  List<VideoFeedModel>? _videoFeedList;

  final notification = getIt<NotificationProvider>();

  final _service = ViedoFeedService(dio: getIt<Dio>());

  bool _loading = false;

  String? _error;

  String? get error => _error;

  bool get isLoading => _loading;
  List<VideoFeedModel> get videoFeedList => (_videoFeedList ?? []);

  bool get hasVideos => (_videoFeedList ?? []).isNotEmpty;
  bool get hasError => _error != null;

  Future<void> fetchVideoFeed() async {
    _loading = true;
    notifyListeners();

    try {
      final videoFeedList = await _service.fetchVideoFeed(page: 1, pageSize: 5);

      _videoFeedList = videoFeedList;
    } catch (e) {
      log('Error fetching video feed: $e');
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
