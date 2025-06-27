import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialverse/core/configs/page_routers/slide_route.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';
import 'package:socialverse/features/videos/widgets/video_feed_tile.dart';

class VideoFeedScreen extends StatefulWidget {
  const VideoFeedScreen({super.key});
  static const String routeName = '/video-feed';

  static Route route() {
    return SlideRoute(
      page: VideoFeedScreen(key: const Key('video-feed-screen')),
    );
  }

  @override
  State<VideoFeedScreen> createState() => _VideoFeedScreenState();
}

class _VideoFeedScreenState extends State<VideoFeedScreen> {
  fetchVideoFeed() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<VideoFeedProvider>(
        context,
        listen: false,
      ).fetchVideoFeed();
    });
  }

  @override
  void initState() {
    fetchVideoFeed();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoFeedProvider>(
      builder: (_, videoProvider, __) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                if (videoProvider.isLoading) CircularProgressIndicator(),
                if (videoProvider.hasError) Text(videoProvider.error!),
                if (!videoProvider.hasVideos) Text('No videos found'),
                if (videoProvider.hasVideos) ...[
                  ListView.builder(
                    itemCount: videoProvider.videoFeedList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final feed = videoProvider.videoFeedList[index];
                      return VideoFeedTile(
                        key: Key(feed.id.toString()),
                        video: feed,
                        onTap: () {},
                        horizontalOffset: 2,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
