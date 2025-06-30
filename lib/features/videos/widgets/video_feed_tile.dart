import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';
import 'package:socialverse/features/videos/providers/post_registry_provider.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';

class VideoFeedTile extends StatefulWidget {
  final VideoFeedModel post;
  final int index;
  const VideoFeedTile({super.key, required this.post, required this.index});

  @override
  State<VideoFeedTile> createState() => _VideoFeedTileState();
}

class _VideoFeedTileState extends State<VideoFeedTile> {
  @override
  void initState() {
    Provider.of<PostRegistryProvider>(
      context,
      listen: false,
    ).setActivePost(widget.post);
    // Provider.of<VideoFeedProvider>(
    //   context,
    //   listen: false,
    // ).fetchPostChildren(post: widget.post);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in right direction
        if (details.delta.dx > 10) {
          print("Swiped Right");
        }

        // Swiping in left direction
        if (details.delta.dx < -10) {
          print("Swiped Left");
        }

        // Swiping in down direction
        if (details.delta.dy > 10) {
          print("Swiped Down");
        }

        // Swiping in up direction
        if (details.delta.dy < -10) {
          print("Swiped Up");
        }
      },
      child: Stack(
        children: [
          SizedBox(
            height: double.maxFinite,
            // height: 650.h,
            width: double.maxFinite,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 12,
                children: [
                  Text(
                    'Post ID: ${widget.post.id}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(widget.post.fullName),
                  Text(widget.post.slug),
                  Text(widget.post.identifier),
                ],
              ),
            ),
          ),

          // PageTile(itemId: widget.video.id),
          // SizedBox(
          //   height: 650.h,
          //   child: CachedNetworkImage(
          //     imageUrl: widget.video.thumbnailUrl,
          //     imageBuilder: (context, imageProvider) => Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 40,
            right: 20,
            child: DotIndicator(video: widget.post, position: widget.index),
          ),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, required this.video, required this.position});
  final int position;

  static const double dotSize = 22.0;
  static const double distance = 28.0;
  final VideoFeedModel video;

  Widget _buildDot(Color color, {String? text}) {
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: text != null ? Center(child: Text(text)) : null,
    );
  }

  Widget _centerIndicator(BuildContext context) {
    return _buildDot(Theme.of(context).colorScheme.primary);
  }

  Widget _textIndicator(String? text) {
    return _buildDot(Colors.white, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: distance * 2 + dotSize,
      height: distance * 2 + dotSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center dot
          _centerIndicator(context),

          // Top dot
          Positioned(
            top: 0,
            child: _textIndicator(video.isChildVideo ? 'H' : null),
          ),

          // Bottom dot
          if (position > 0)
            Positioned(bottom: 0, child: _textIndicator(position.toString())),

          // Left dot
          if (!video.isGrandPost)
            Positioned(left: 0, child: _textIndicator('P')),

          // Right dot
          if (video.hasChildren)
            Positioned(
              right: 0,
              child: _textIndicator(
                video.isParentVideo ? video.childVideoCount.toString() : '',
              ),
            ),
        ],
      ),
    );
  }
}

class PageTile extends StatefulWidget {
  final int itemId;
  const PageTile({super.key, required this.itemId});

  @override
  State<PageTile> createState() => _PageTileState();
}

class _PageTileState extends State<PageTile> {
  late List<String> pages;

  @override
  void initState() {
    super.initState();

    // Show the first page immediately
    pages = ["Tile ${widget.itemId} - Page 0"];

    // Then fetch and add more
    _fetchMorePages();
  }

  Future<void> _fetchMorePages() async {
    await Future.delayed(Duration(milliseconds: 10_000));
    final more = List.generate(
      4,
      (i) => "Tile ${widget.itemId} - Page ${i + 1}",
    );
    if (mounted) {
      setState(() {
        pages.addAll(more); // Append more items
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 650.h,
          child: Card(
            margin: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: pages.length,
              controller: PageController(viewportFraction: 0.85),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[300 + ((index % 3) * 100)],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      pages[index],
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
