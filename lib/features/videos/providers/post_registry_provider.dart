import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';

class PostRegistryProvider extends ChangeNotifier {
  final Map<String, VideoFeedModel> _visitedNodes = {};

  int _verticalIndex = 0;
  int _horizontalIndex = 0;

  int get horizontalIndex => _horizontalIndex;

  int get verticalIndex => _verticalIndex;

  void onVerticalScroll(int verticalIndex) {
    _verticalIndex = verticalIndex;
  }

  void onHorizontalScroll(int horizontalIndex) {
    _horizontalIndex = horizontalIndex;
  }

  void onScroll({required VideoFeedModel video}) {
    _addVideoToNodeList(video);
  }

  void onScrollUp({required VideoFeedModel video}) {}
  void onScrollDown({required VideoFeedModel video}) {}
  void onScrollLeft({required VideoFeedModel video}) {}
  void onScrollRight({required VideoFeedModel video}) {}

  void _addVideoToNodeList(VideoFeedModel videoNode) {
    // reset navigation stack when on parent node
    if (videoNode.isParentVideo) {
      _visitedNodes.clear();
    } else {
      _visitedNodes.addAll({'${videoNode.id}': videoNode});
    }
  }

  VideoFeedModel? getVideoNodeById(String postId) => _visitedNodes[postId];
}
