import 'dart:math';

import 'package:dio/dio.dart';
import 'package:socialverse/core/core.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import '../domain/services/video_feed_service.dart';

class PostState {
  final VideoFeedModel post;
  final List<VideoFeedModel>? childPosts;
  final List<VideoFeedModel>? postReplies;

  PostState({required this.post, this.childPosts, this.postReplies});

  List<VideoFeedModel> getChildPosts() {
    return childPosts ?? [];
  }

  List<VideoFeedModel> getPostReplies() {
    return postReplies ?? [];
  }

  PostState copyWith({
    List<VideoFeedModel>? childPosts,
    List<VideoFeedModel>? postReplies,
  }) {
    return PostState(
      post: post,
      childPosts: childPosts ?? this.childPosts,
      postReplies: postReplies ?? this.postReplies,
    );
  }
}

class VideoFeedProvider extends ChangeNotifier {
  List<VideoFeedModel>? _videoFeedList;
  final Map<String, List<VideoFeedModel>> _videoRepliesList = {};

  final Map<String, PostState> _postRepliesList = {};

  final notification = getIt<NotificationProvider>();

  final _service = ViedoFeedService(dio: getIt<Dio>());

  bool _loading = false;

  String? _error;

  String? get error => _error;

  bool get isLoading => _loading;
  List<VideoFeedModel> get videoFeedList => (_videoFeedList ?? []);

  bool get hasVideos => (_videoFeedList ?? []).isNotEmpty;
  bool get hasError => _error != null;

  PostState? getPostState(VideoFeedModel post) {
    return _postRepliesList[post.id.toString()];
  }

  PostState? getPostReplies(VideoFeedModel post) {
    return _postRepliesList[post.id.toString()];
  }

  Future<void> fetchVideoFeed() async {
    _loading = true;
    notifyListeners();

    try {
      final videoFeedList = await _service.fetchVideoFeed(page: 1, pageSize: 5);

      _videoFeedList = videoFeedList;
    } catch (e) {
      logger.error('Error fetching video feed: $e');
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

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

  Future<void> fetchPostChildren({required VideoFeedModel post}) async {
    logger.error('fetchPostChildren');
    // final childPosts = List.generate(post.childVideoCount, (_) => post);
    final postId = post.id.toString();
    try {
      final posts = await _service.fetchVideoFeedReplies(
        videoId: post.id,
        page: 1,
        pageSize: 5,
      );
      // final videoReplies = selectRandomItems(posts, post.childVideoCount);
      if (_postRepliesList.containsKey(post.id.toString())) {
        final postState = _postRepliesList[postId]!;
        postState.copyWith(childPosts: posts);
        _postRepliesList[postId] = postState;
      } else {
        _postRepliesList[postId] = PostState(
          post: post,
          childPosts: posts,
        );
      }
    } catch (e, stackTrace) {
      logger.error({e,stackTrace});
      notification.show(
        title: 'Something went wrong',
        type: NotificationType.local,
      );
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPostReplies({required VideoFeedModel post}) async {
    logger.error('fetchPostReplies');
    try {
      // final replies = List.generate(post.totalReplies ?? 0, (_) => post);
      final posts = await _service.fetchVideoFeedReplies(
        videoId: post.id,
        page: 1,
        pageSize: 5,
      );
      // final generatedReplies = selectRandomItems(posts, post.totalReplies ?? 0);
      final postId = post.id.toString();
      if (_postRepliesList.containsKey(post.id.toString())) {
        final postState = _postRepliesList[postId]!;
        postState.copyWith(postReplies: posts);
        _postRepliesList[postId] = postState;
      } else {
        _postRepliesList[postId] = PostState(
          post: post,
          postReplies: posts,
        );
      }
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

List<T> selectRandomItems<T>(List<T> list, int n) {
  if (n == 0) return [];
  if (n >= list.length) {
    return List.from(list);
  }
  final random = Random();
  final copy = List<T>.from(list)..shuffle(random);

  return copy.take(n).toList();
}
