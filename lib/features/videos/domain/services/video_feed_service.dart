import 'package:dio/dio.dart';
import 'package:socialverse/core/utils/logger/logger.dart';
import 'package:socialverse/export.dart';
import 'package:socialverse/features/videos/domain/models/video_feed_model.dart';

class ViedoFeedService {
  late final Dio _dio;

  ViedoFeedService({required Dio dio}) {
    _dio = dio;
  }

  Future<List<VideoFeedModel>> fetchVideoFeed({
    required int page,
    required int pageSize,
  }) async {
    try {
      // Response response = await _dio.get(
      //   'https://api.wemotions.app/feed?page=$page&page_size=$pageSize',
      // );
      // logger.info(response.data);
      // final list = (response.data['posts'] as List).map(
      //   (json) => VideoFeedModel.fromJson(json),
      // );
      final list = (_parentVideos['posts'] as List).map(
        (json) => VideoFeedModel.fromJson(json),
      );
      return list.toList();
    } on DioException catch (e) {
      logger.error(e.message);
      logger.error(e.type);
      throw 'Something Went Wrong';
    } catch (error) {
      logger.error(error);
      throw 'Something Went Wrong';
    }
  }

  Future<List<VideoFeedModel>> fetchVideoFeedReplies({
    required int videoId,
    int page = 1,
    int pageSize = 5,
  }) async {
    // print('${API.endpoint}${API.profile}/$videoId');
    try {
      // Response response = await _dio.get(
      //   'https://api.wemotions.app/posts/$videoId/replies?page=$page&page_size=$pageSize',
      // );
      // print(response.data);
      // final list = (response.data as List).map(
      //   (json) => VideoFeedModel.fromJson(json),
      // );
      final list = (_repliesFor218['post'] as List).map(
        (json) => VideoFeedModel.fromJson(json),
      );
      return list.toList();
    } on DioError catch (e) {
      print(e.response?.statusMessage);
      print(e.response?.statusCode);

      if (e.response?.statusCode == 404) {
        throw 'Video not found';
      }
      throw 'Something Went Wrong';
    }
  }
}

Map<String, dynamic> get _parentVideos => {
  "page": 1,
  "max_page_size": 10,
  "page_size": 10,
  "posts": [
    {
      "id": 218,
      "category": [],
      "slug": "06ec45fd3b3de59c1bac32b3c26ae0aab2a418b0",
      "parent_video_id": null,
      "child_video_count": 3,
      "title": "Success: Born from 100 Almost-Give-Up Moments",
      "identifier": "NVTJT88",
      "comment_count": 0,
      "upvote_count": 3,
      "view_count": 73,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/nidhi_3a26a47b-0f5a-421f-a200-303eb89dc797.mp4",
      "is_locked": false,
      "created_at": 1748205700000,
      "first_name": "Nidhii",
      "last_name": "Gupta",
      "username": "nids",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/nidhi_3a26a47b-0f5a-421f-a200-303eb89dc797.0000002.jpg",
      "following": false,
      "picture_url": "https://wemotions-assets.s3.amazonaws.com/profile/14.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 220,
      "category": [],
      "slug": "4a5e32e803e3fbde33761162cd329b149db21e93",
      "parent_video_id": null,
      "child_video_count": 5,
      "title": "Aliens, AI, and the Future of Intelligence",
      "identifier": "mvQlf6T",
      "comment_count": 0,
      "upvote_count": 3,
      "view_count": 56,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/alfi_731e60a7-b822-48d8-b763-63b16c6ecf57.mp4",
      "is_locked": false,
      "created_at": 1748206880000,
      "first_name": "Alfi",
      "last_name": "M",
      "username": "alfi",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/alfi_731e60a7-b822-48d8-b763-63b16c6ecf57.0000002.jpg",
      "following": false,
      "picture_url":
          "https://assets.wemotions.app/profile/alfi1750248858image_cropper_9A8D46C3-FE22-4356-8EC6-90F7D9EBB700-30624-0000028CDBDB0AA8.jpg.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 212,
      "category": [],
      "slug": "be02818b24ebb7c0ea732ee8e66a0755db15c649",
      "parent_video_id": null,
      "child_video_count": 3,
      "title": "Ai making our life simple is this good idea",
      "identifier": "Zvqzj-N",
      "comment_count": 0,
      "upvote_count": 1,
      "view_count": 45,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/neha_d6547c81-278e-4c4d-8144-18651e7b857f.mp4",
      "is_locked": false,
      "created_at": 1748199183000,
      "first_name": "Neha",
      "last_name": "Bhasin",
      "username": "neha",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/neha_d6547c81-278e-4c4d-8144-18651e7b857f.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/16.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 211,
      "category": [],
      "slug": "b7ab11e3973bc57eb95b9ed5b1dca371180f7248",
      "parent_video_id": null,
      "child_video_count": 1,
      "title":
          "Wemotions: Real Conversations, Real Faces — Say Goodbye to Fake Social Media",
      "identifier": "LealzQw",
      "comment_count": 0,
      "upvote_count": 1,
      "view_count": 45,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/nidhi_2e957742-2bed-423e-8af1-7949ea713eee.mp4",
      "is_locked": false,
      "created_at": 1748197038000,
      "first_name": "Nidhii",
      "last_name": "Gupta",
      "username": "nids",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/nidhi_2e957742-2bed-423e-8af1-7949ea713eee.0000002.jpg",
      "following": false,
      "picture_url": "https://wemotions-assets.s3.amazonaws.com/profile/14.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 208,
      "category": {
        "id": 2,
        "name": "Backend Worriers",
        "count": 9,
        "description":
            "Code ninjas handling all the behind-the-scenes magic, making sure the app runs smooth and data flows like a boss!",
        "image_url":
            "https://assets.wemotions.app/categories/doremon671f8435770f9",
      },
      "slug": "703b4e8c014ae83bed7394613e9883fd9a016ac0",
      "parent_video_id": null,
      "child_video_count": 1,
      "title": "replying",
      "identifier": "R_E96DJ",
      "comment_count": 0,
      "upvote_count": 3,
      "view_count": 41,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/jack_c459ebe9-a86c-448c-b4cf-96aba5e55e5a.mp4",
      "is_locked": false,
      "created_at": 1746646964000,
      "first_name": "Jack",
      "last_name": "Jay",
      "username": "jack",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/jack_c459ebe9-a86c-448c-b4cf-96aba5e55e5a.0000002.jpg",
      "following": false,
      "picture_url": "https://wemotions-assets.s3.amazonaws.com/profile/15.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 215,
      "category": [],
      "slug": "83366e56b4f05908a959bc937f895c646fe4bca5",
      "parent_video_id": null,
      "child_video_count": 0,
      "title": "Time Travel: Fixing the Past or Breaking the Present?",
      "identifier": "tHkmnXO",
      "comment_count": 0,
      "upvote_count": 1,
      "view_count": 41,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/mahek07_d6d647fe-a790-4a7b-bca9-68488bfc83e4.mp4",
      "is_locked": false,
      "created_at": 1748202371000,
      "first_name": "Mahek",
      "last_name": "Holsekar",
      "username": "mahek07",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/mahek07_d6d647fe-a790-4a7b-bca9-68488bfc83e4.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/11.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 368,
      "category": {
        "id": 2,
        "name": "Backend Worriers",
        "count": 9,
        "description":
            "Code ninjas handling all the behind-the-scenes magic, making sure the app runs smooth and data flows like a boss!",
        "image_url":
            "https://assets.wemotions.app/categories/doremon671f8435770f9",
      },
      "slug": "f76e7560b09d8c105da14948f28b0b325cc1ecc2",
      "parent_video_id": null,
      "child_video_count": 1,
      "title": "video upload error? compressed vertically",
      "identifier": "6ke4tns",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 18,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/syd_0e806e15-9dca-4215-9c2b-c2f5c409cfcf.mp4",
      "is_locked": false,
      "created_at": 1750716676000,
      "first_name": "Sydney",
      "last_name": "Borden",
      "username": "syd",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/syd_0e806e15-9dca-4215-9c2b-c2f5c409cfcf.0000002.jpg",
      "following": false,
      "picture_url":
          "https://assets.wemotions.app/profile/syd1750659364image_cropper_BEF33479-7A0E-43AB-978B-B969D22C0D1B-616-0000000936C3969B.jpg.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 217,
      "category": [],
      "slug": "6445c1ee1885635ab84b76b13933d956a5e1263f",
      "parent_video_id": null,
      "child_video_count": 0,
      "title": "Wealth vs. Knowledge: What Truly Shapes Success?",
      "identifier": "7d8u29G",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 38,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/alfi_458e115a-5e2c-437b-882e-d5db32a98c4a.mp4",
      "is_locked": false,
      "created_at": 1748205013000,
      "first_name": "Alfi",
      "last_name": "M",
      "username": "alfi",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/alfi_458e115a-5e2c-437b-882e-d5db32a98c4a.0000002.jpg",
      "following": false,
      "picture_url":
          "https://assets.wemotions.app/profile/alfi1750248858image_cropper_9A8D46C3-FE22-4356-8EC6-90F7D9EBB700-30624-0000028CDBDB0AA8.jpg.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 226,
      "category": [],
      "slug": "2e0826651bee75da3a0d8dd05a9d81b2b674827c",
      "parent_video_id": null,
      "child_video_count": 0,
      "title": "Greatness Starts Small",
      "identifier": "K20wRm3",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 27,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/ekta_12dbd031-06c7-4fe4-8ee6-4948f0d638b2.mp4",
      "is_locked": false,
      "created_at": 1748342741000,
      "first_name": "Ekta",
      "last_name": "Tewatiya",
      "username": "ekta",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/ekta_12dbd031-06c7-4fe4-8ee6-4948f0d638b2.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/4.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 235,
      "category": [],
      "slug": "d0e8b98783985ab74637f34f7153381baf220668",
      "parent_video_id": null,
      "child_video_count": 0,
      "title": "Choosing Between Engineering and Medicine: Following the Heart",
      "identifier": "4Dz2HBT",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 31,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/simran_7f8e47a7-2204-46bd-876e-495324a5daae.mp4",
      "is_locked": false,
      "created_at": 1748437718000,
      "first_name": "Simran",
      "last_name": "Shaikh",
      "username": "simran",
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/simran_7f8e47a7-2204-46bd-876e-495324a5daae.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/6.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
  ],
};

Map<String, dynamic> get _repliesFor218 => {
  "status": "success",
  "message": "Replies for post 218 fetched successfully",
  "page": 1,
  "max_page_size": 5,
  "page_size": 3,
  "post": [
    {
      "id": 219,
      "category": [],
      "slug": "4c019415d6187f46f600bb7ea0878a9b7345d5ae",
      "parent_video_id": 218,
      "child_video_count": 1,
      "title": "Patience: The True Key to Success",
      "identifier": "KT1W6Jw",
      "comment_count": 0,
      "upvote_count": 2,
      "view_count": 7,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/alfi_bbd0171b-6355-4aea-abd0-74c39bbaef00.mp4",
      "is_locked": false,
      "created_at": 1748206077000,
      "first_name": "Alfi",
      "last_name": "M",
      "username": "alfi",
      "replier_type": "slow_replier",
      "no_of_replies": 1,
      "avg_reply_min": 44090,
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/alfi_bbd0171b-6355-4aea-abd0-74c39bbaef00.0000002.jpg",
      "following": false,
      "picture_url":
          "https://assets.wemotions.app/profile/alfi1750248858image_cropper_9A8D46C3-FE22-4356-8EC6-90F7D9EBB700-30624-0000028CDBDB0AA8.jpg.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 224,
      "category": [],
      "slug": "ba9554a51fd243a06043daaaefc9c26c65acd282",
      "parent_video_id": 218,
      "child_video_count": 1,
      "title": "Success Is a Journey",
      "identifier": "9ZKfaJd",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 7,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/ekta_b2b1de02-0e5d-4976-a2cf-3e6e40101ff7.mp4",
      "is_locked": false,
      "created_at": 1748275088000,
      "first_name": "Ekta",
      "last_name": "Tewatiya",
      "username": "ekta",
      "replier_type": "slow_replier",
      "no_of_replies": 1,
      "avg_reply_min": 2531,
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/ekta_b2b1de02-0e5d-4976-a2cf-3e6e40101ff7.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/4.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
    {
      "id": 376,
      "category": [],
      "slug": "82fe2ee729cc6025c9c6a43465fc5c89f200f07b",
      "parent_video_id": 218,
      "child_video_count": 0,
      "title": "Reply test 1",
      "identifier": "on2wMrP",
      "comment_count": 0,
      "upvote_count": 0,
      "view_count": 3,
      "share_count": 0,
      "tag_count": 0,
      "video_link":
          "https://video-cdn.wemotions.app/arunn04_bc53f806-bfcf-49c3-91a9-08b51711ebfa.mp4",
      "is_locked": false,
      "created_at": 1750847977000,
      "first_name": "Arun",
      "last_name": "Kumar",
      "username": "arunn04",
      "replier_type": "new_user",
      "no_of_replies": 0,
      "avg_reply_min": 0,
      "upvoted": false,
      "bookmarked": false,
      "thumbnail_url":
          "https://video-cdn.wemotions.app/arunn04_bc53f806-bfcf-49c3-91a9-08b51711ebfa.0000002.jpg",
      "following": false,
      "picture_url": "https://assets.wemotions.app/profile/14.png",
      "voting_count": 0,
      "votings": [],
      "tags": [],
    },
  ],
};
