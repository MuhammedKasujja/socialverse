import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/core/utils/logger/logger.dart';
import 'package:socialverse/features/home/helper/v_video_scroll_physics.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import 'package:socialverse/features/videos/providers/post_registry_provider.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';
import 'package:socialverse/features/videos/widgets/video_feed_tile.dart';

class VerticalFeedList extends StatelessWidget {
  const VerticalFeedList({super.key, required this.posts});
  final List<VideoFeedModel> posts;

  @override
  Widget build(BuildContext context) {
    return  PageView.builder(
        scrollDirection: Axis.vertical,
        physics: VideoScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return FourWaySwipeHandler(index: index, post: posts[index]);
        },
    );
  }
}

class FourWaySwipeHandler extends StatefulWidget {
  final int index;
  final VideoFeedModel post;

  const FourWaySwipeHandler({
    super.key,
    required this.index,
    required this.post,
  });

  @override
  State<FourWaySwipeHandler> createState() => _FourWaySwipeHandlerState();
}

class _FourWaySwipeHandlerState extends State<FourWaySwipeHandler> {
  Axis _lockedAxis = Axis.horizontal;

  @override
  void initState() {
    Provider.of<VideoFeedProvider>(
      context,
      listen: false,
    ).fetchPostChildren(post: widget.post);
    super.initState();
  }

  void _setAxis(Axis axis) {
    final activePost = context.read<PostRegistryProvider>().activePost;
    // logger.info({'Change direction': activePost?.id, 'Axis': axis});
    if (axis == Axis.vertical && (!activePost!.hasReplies || activePost.isGrandPost)) return;
    if (_lockedAxis != axis) {
      setState(() => _lockedAxis = axis);
      if (axis == Axis.vertical && activePost!.hasReplies) {
        // final activePost = context.read<PostRegistryProvider>().activePost;
        Provider.of<VideoFeedProvider>(
          context,
          listen: false,
        ).fetchPostReplies(post: activePost);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    // always load the current active post
    
    return Consumer<PostRegistryProvider>(
      builder: (context, postProvider, __) {
        logger.debug(postProvider.activePost?.toJson());
        return Consumer<VideoFeedProvider>(
          builder: (context, provider, _) {
            if(postProvider.activePost == null) return Text('No post');
            final postState = provider.getPostState(postProvider.activePost!);
            return RawGestureDetector(
              gestures: {
                CustomDirectionRecognizer:
                    GestureRecognizerFactoryWithHandlers<CustomDirectionRecognizer>(
                      () => CustomDirectionRecognizer(),
                      (instance) {
                        instance.onDirectionLocked = _setAxis;
                      },
                    ),
              },
              behavior: HitTestBehavior.translucent,
              child: _lockedAxis == Axis.horizontal
                  ? PostListView(
                      posts: [post, ...postState?.getChildPosts() ?? []],
                      scrollDirection: Axis.horizontal,
                    )
                  // :PostListView(
                  //   posts: [post, ...postState?.getChildPosts() ?? []],
                  //   scrollDirection: Axis.vertical,
                  // )
                  : VerticalDetailsView(
                      index: widget.index,
                      // posts: postState?.getPostReplies() ?? [],
                      onScrollToTop: ()=>_setAxis(Axis.horizontal),
                    ),
            );
          },
        );
      }
    );
  }
}

class HorizontalCarousel extends StatelessWidget {
  final int index;
  final List<VideoFeedModel> posts;

  const HorizontalCarousel({
    super.key,
    required this.index,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: posts.length,
      physics: VideoScrollPhysics(),
      itemBuilder: (_, i) {
        return InnerVerticalContent(
          color: Colors.primaries[(index + i) % Colors.primaries.length],
          label: 'Feed $index - Page $i',
        );
      },
    );
  }
}

class InnerVerticalContent extends StatelessWidget {
  final String label;
  final Color color;

  const InnerVerticalContent({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        children: [
          SizedBox(height: 48),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 24)),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Comment $i',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalDetailsView extends StatefulWidget {
  final int index;
  final VoidCallback onScrollToTop;

  const VerticalDetailsView({
    super.key,
    required this.index,
    required this.onScrollToTop,
  });

  @override
  State<VerticalDetailsView> createState() => _VerticalDetailsViewState();
}

class _VerticalDetailsViewState extends State<VerticalDetailsView> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  void _onVerticalSwipe(DragUpdateDetails details) {
    final dy = details.primaryDelta ?? 0;

    if (dy > 12 && _currentPage == 0) {
      // Swiped down from first page — exit
      widget.onScrollToTop();
    } else if (dy < -12 && _currentPage < 2) {
      // Swiped up — go next
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (dy > 12 && _currentPage > 0) {
      // Swiped down — go back
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalSwipe,
      child: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemBuilder: (_, i) {
          return Container(
            color: Colors.accents[(widget.index + i) % Colors.accents.length],
            child: Center(
              child: Text(
                i == 0
                    ? 'Intro View $i\nSwipe up to see more'
                    : 'Detail Page $i\nSwipe down to go back',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }
}


// class VerticalDetailsView extends StatelessWidget {
//   final int index;
//   final List<VideoFeedModel> posts;

//   const VerticalDetailsView({
//     super.key,
//     required this.index,
//     required this.posts,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: posts.length,
//       physics: VideoScrollPhysics(),
//       itemBuilder: (_, i) {
//         return Center(
//           child: Text(
//             'Vertical Detail View $index\n(Swipe horizontal to go back) ${i + 1}\n PostID: ${posts[i].id}',
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 22),
//           ),
//         );
//       },
//     );

//     return Center(
//       child: Text(
//         'Vertical Detail View $index\n(Swipe horizontal to go back)',
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 22),
//       ),
//     );
//   }
// }

class CustomDirectionRecognizer extends OneSequenceGestureRecognizer {
  Offset _start = Offset.zero;
  bool _locked = false;
  void Function(Axis)? onDirectionLocked;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    _start = event.position;
    _locked = false;
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent && !_locked) {
      final delta = event.position - _start;
      final angle = delta.direction;

      if (delta.distance > 12) {
        _locked = true;
        final axis =
            (angle.abs() > math.pi / 4 && angle.abs() < 3 * math.pi / 4)
            ? Axis.vertical
            : Axis.horizontal;
        onDirectionLocked?.call(axis);
      }
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
  @override
  String get debugDescription => 'CustomDirectionRecognizer';
}

class PostListView extends StatelessWidget {
  final List<VideoFeedModel> posts;
  final Axis scrollDirection;

  const PostListView({
    super.key,
    required this.posts,
    required this.scrollDirection,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: scrollDirection,
      itemCount: posts.length,
      physics: VideoScrollPhysics(),
      itemBuilder: (_, index) {
        final post = posts[index];
        final count = post.isGrandPost
            ? posts.length - index
            : post.totalReplies ?? 0;
        return VideoFeedTile(post: post, index: count);
      },
    );
  }
}
