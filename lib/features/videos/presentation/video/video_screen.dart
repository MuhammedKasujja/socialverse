import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/presentation/scroll_children_screen.dart';
import 'package:socialverse/features/videos/providers/video_feed_provider.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
        if (videoProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (videoProvider.hasError) {
          return Center(child: Text(videoProvider.error!));
        }
        if (!videoProvider.hasVideos) {
          return Center(child: Text('No videos found'));
        }
        return VerticalFeedList(posts: videoProvider.videoFeedList);
      },
    );
  }
}
