import 'package:socialverse/core/configs/page_routers/slide_route.dart';
import 'package:socialverse/core/utils/logger/logger.dart';
import 'package:socialverse/export.dart';
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
  var scrollDirection = Axis.horizontal;
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
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            print('Swiping down');
          } else if (details.delta.dy < 0) {
            print('Swiping up');
          }
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3, // Up/Down Pages
          onPageChanged: (verticalPage) {
            logger.info({"VertPage":verticalPage});
          },
          itemBuilder: (context, verticalIndex) {
            return PageView.builder(
              scrollDirection: scrollDirection,
              itemCount: 4, // Left/Right Pages
              onPageChanged: (page) {
                logger.info({'HoriPage':page});
              },
              itemBuilder: (context, horizontalIndex) {
                return Container(
                  color:
                      Colors.primaries[(verticalIndex * 3 + horizontalIndex) %
                          Colors.primaries.length],
                  child: Center(
                    child: Text(
                      'Page ($verticalIndex, $horizontalIndex)',
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Consumer<VideoFeedProvider>(
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
            if (videoProvider.hasVideos) {
              return ListView.builder(
                itemCount: videoProvider.videoFeedList.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  final feed = videoProvider.videoFeedList[index];
                  return VideoFeedTile(
                    // key: Key(feed.id.toString()),
                    video: feed,
                    onTap: () {},
                  );
                  // return SizedBox(
                  //   height: 650.h, // height for each swiper tile
                  //   child: CardSwiper(
                  //     allowedSwipeDirection: AllowedSwipeDirection.only(
                  //       left: true,
                  //       right: true,
                  //     ),
                  //     cardsCount: 5,
                  //     cardBuilder: (context, cardIndex, _, _) {
                  //       return CachedNetworkImage(
                  //         imageUrl: feed.thumbnailUrl,
                  //         imageBuilder: (context, imageProvider) => Container(
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             image: DecorationImage(
                  //               image: imageProvider,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // );
                },
              );
            }

            // ListView.builder(
            //   itemCount: videoProvider.videoFeedList.length,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     final feed = videoProvider.videoFeedList[index];
            //     return VideoFeedTile(
            //       key: Key(feed.id.toString()),
            //       video: feed,
            //       onTap: () {},
            //       horizontalOffset: 2,
            //     );
            //   },
            // ),
            return Text('No data found');
          },
        ),
      ),
    );
  }
}

class PageState extends ChangeNotifier {
  int verticalPageIndex = 0;
  final Map<int, int> horizontalPageIndices = {};

  int getHorizontalPageIndex(int verticalIndex) =>
      horizontalPageIndices[verticalIndex] ?? 0;

  void setVerticalPageIndex(int index) {
    if (verticalPageIndex != index) {
      verticalPageIndex = index;
      notifyListeners();
    }
  }

  void setHorizontalPageIndex(int verticalIndex, int horizontalIndex) {
    if (horizontalPageIndices[verticalIndex] != horizontalIndex) {
      horizontalPageIndices[verticalIndex] = horizontalIndex;
      notifyListeners();
    }
  }
}

class Manual2DPageView extends StatefulWidget {
  const Manual2DPageView({super.key});

  @override
  State<Manual2DPageView> createState() => _Manual2DPageViewState();
}

class _Manual2DPageViewState extends State<Manual2DPageView> {
  static const int verticalCount = 3;
  static const int horizontalCount = 3;

  late PageController verticalController;

  // Track horizontal page index for each vertical page
  final Map<int, int> horizontalPageIndices = {};

  @override
  void initState() {
    super.initState();
    verticalController = PageController();
  }

  @override
  void dispose() {
    verticalController.dispose();
    super.dispose();
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    verticalController.position.jumpTo(
      verticalController.position.pixels - details.delta.dy,
    );
  }

  void onVerticalDragEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dy;
    final currentPage = verticalController.page ?? 0;

    int targetPage = currentPage.round();
    if (velocity.abs() > 300) {
      targetPage = velocity < 0 ? targetPage + 1 : targetPage - 1;
    }
    targetPage = targetPage.clamp(0, verticalCount - 1);

    verticalController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: onVerticalDragUpdate,
        onVerticalDragEnd: onVerticalDragEnd,
        behavior: HitTestBehavior.opaque,
        child: PageView.builder(
          controller: verticalController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: verticalCount,
          itemBuilder: (context, vIndex) {
            int hIndex = horizontalPageIndices[vIndex] ?? 0;
            PageController horizontalController = PageController(
              initialPage: hIndex,
            );

            void onHorizontalDragUpdate(DragUpdateDetails details) {
              horizontalController.position.jumpTo(
                horizontalController.position.pixels - details.delta.dx,
              );
            }

            void onHorizontalDragEnd(DragEndDetails details) {
              final velocity = details.velocity.pixelsPerSecond.dx;
              final currentPage = horizontalController.page ?? 0;

              int targetPage = currentPage.round();
              if (velocity.abs() > 300) {
                targetPage = velocity < 0 ? targetPage + 1 : targetPage - 1;
              }
              targetPage = targetPage.clamp(0, horizontalCount - 1);

              horizontalController.animateToPage(
                targetPage,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );

              setState(() {
                horizontalPageIndices[vIndex] = targetPage;
              });
            }

            return GestureDetector(
              onHorizontalDragUpdate: onHorizontalDragUpdate,
              onHorizontalDragEnd: onHorizontalDragEnd,
              behavior: HitTestBehavior.translucent,
              child: PageView.builder(
                controller: horizontalController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: horizontalCount,
                itemBuilder: (context, hIndex) {
                  return Container(
                    color:
                        Colors.primaries[(vIndex * horizontalCount + hIndex) %
                            Colors.primaries.length],
                    child: Center(
                      child: Text(
                        'Page ($vIndex, $hIndex)',
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
