import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/features/home/helper/v_video_scroll_physics.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';
import 'package:socialverse/features/videos/widgets/video_feed_tile.dart';

class VerticalFeedList extends StatelessWidget {
  const VerticalFeedList({super.key, required this.posts});
  final List<VideoFeedModel> posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        physics: VideoScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return FourWaySwipeHandler(index: index, post: posts[index]);
        },
      ),
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
    if (_lockedAxis != axis) {
      setState(() => _lockedAxis = axis);
      if (axis == Axis.vertical) {
        Provider.of<VideoFeedProvider>(
          context,
          listen: false,
        ).fetchPostReplies(post: widget.post);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return Consumer<VideoFeedProvider>(
      builder: (context, provider, _) {
        final postState = provider.getPostState(post);
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
              : VerticalDetailsView(
                  index: widget.index,
                  posts: [post, ...postState?.getPostReplies() ?? []],
                ),
        );
      },
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

class VerticalDetailsView extends StatelessWidget {
  final int index;
  final List<VideoFeedModel> posts;

  const VerticalDetailsView({
    super.key,
    required this.index,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    // return PageView.builder(
    //   scrollDirection: Axis.vertical ,
    //   itemCount: 2,
    //   physics: VideoScrollPhysics(),
    //   itemBuilder: (_, i) {
    //     return Center(
    //       child: Text(
    //         'Vertical Detail View $index\n(Swipe horizontal to go back) ${i+1}',
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: 22),
    //       ),
    //     );
    //   },
    // );

    return Center(
      child: Text(
        'Vertical Detail View $index\n(Swipe horizontal to go back)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}

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
        return VideoFeedTile(post: posts[index]);
      },
    );
  }
}
