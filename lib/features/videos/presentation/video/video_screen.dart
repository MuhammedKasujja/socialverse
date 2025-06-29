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
        return VerticalFeedList(posts: videoProvider.videoFeedList);
      },
    );
  }
}
