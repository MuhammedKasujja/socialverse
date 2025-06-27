// Flutter & Dart
export 'package:flutter/material.dart' hide SearchBar;
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/scheduler.dart' hide timeDilation;
export 'package:flutter/services.dart';
export 'package:socialverse/main.dart';
export 'package:flutter/foundation.dart' hide Category;
export 'dart:convert';
export 'dart:async';
export 'dart:io';
export 'package:socialverse/app.dart';

// Packages
// export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:share_plus/share_plus.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:video_player/video_player.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:wechat_assets_picker/wechat_assets_picker.dart';
export 'package:percent_indicator/percent_indicator.dart';
export 'package:path/path.dart' hide context;
// export 'package:image_gallery_saver/image_gallery_saver.dart';
export 'package:path_provider/path_provider.dart';
export 'package:image_picker/image_picker.dart';
export 'package:image_cropper/image_cropper.dart';
export 'package:permission_handler/permission_handler.dart';
export 'package:shared_preferences/shared_preferences.dart';
// export 'package:unicons/unicons.dart';
// export 'package:camera/camera.dart';
export 'package:provider/provider.dart';
// export 'package:flutter_stripe/flutter_stripe.dart' hide Card;
export 'package:qr_flutter/qr_flutter.dart';
// export 'package:screenshot/screenshot.dart';
// export 'package:qr_code_scanner/qr_code_scanner.dart' hide CameraException;
// export 'package:flutter_switch/flutter_switch.dart';
// export 'package:flutter_dotenv/flutter_dotenv.dart';
// export 'package:firebase_crashlytics/firebase_crashlytics.dart';
// export 'package:firebase_messaging/firebase_messaging.dart';
// export 'package:home_widget/home_widget.dart';
export 'package:shimmer/shimmer.dart';
// export 'package:audioplayers/audioplayers.dart';
// export 'package:flutter_linkify/flutter_linkify.dart';



// Utils, Widgets, Constants, Extensions, Configs
// export 'package:socialverse/app.dart';
export 'package:socialverse/core/utils/constants/api_paths.dart';
export 'package:socialverse/core/utils/constants/assets.dart';
export 'package:socialverse/core/utils/constants/constants.dart';
export 'package:socialverse/core/utils/constants/static_sizes.dart';
export 'package:socialverse/core/widgets/progress_indicator.dart';
export 'package:socialverse/core/widgets/custom_button.dart';
export 'package:socialverse/core/widgets/custom_circular_avatar.dart';
export 'package:socialverse/core/widgets/camera_selector.dart';
export 'package:socialverse/core/widgets/camera_button.dart';

export 'package:socialverse/core/configs/injection/locator.dart';
//
export 'package:socialverse/core/utils/extensions/date_extension.dart';
export 'package:socialverse/core/utils/extensions/form_extension.dart';
//
export 'package:socialverse/core/utils/network/internet_error.dart';
export 'package:socialverse/core/utils/network/network_dio.dart';

export 'package:socialverse/core/utils/style/text_style.dart';
export 'package:socialverse/core/utils/style/text_form_decoration.dart';
export 'package:socialverse/core/utils/theme/theme.dart';

export 'package:socialverse/core/widgets/overlay_notification.dart';
export 'package:socialverse/core/widgets/custom_network_image.dart';


// Models, Services, Repositories
export 'package:socialverse/core/domain/models/category_model.dart';
export 'package:socialverse/core/domain/models/notifications_model.dart';
export 'package:socialverse/core/domain/models/post_model.dart';
export 'package:socialverse/core/domain/models/notification_model.dart';

// Providers
// export 'package:socialverse/core/providers/bottom_nav_provider.dart';
// export 'package:socialverse/core/providers/notification_provider.dart';
export 'package:socialverse/core/providers/theme_provider.dart';
export 'package:socialverse/core/providers/report_provider.dart';
export 'package:socialverse/core/providers/notification_provider.dart';
export 'package:socialverse/core/providers/bottom_nav_provider.dart';
// export 'package:socialverse/features/home/providers/exit_provider.dart';

// export 'package:socialverse/core/providers/snackbar_provider.dart';


// export 'package:socialverse/features/profile/providers/edit_profile/edit_profile_provider.dart';
// export 'package:socialverse/features/profile/providers/profile/profile_provider.dart';
// export 'package:socialverse/features/profile/providers/profile/user_profile_provider.dart';

// export 'package:socialverse/features/profile/providers/settings/account_provider.dart';
// export 'package:socialverse/features/profile/providers/settings/invite_provider.dart';
// export 'package:socialverse/features/profile/providers/settings/qr_code_provider.dart';
// export 'package:socialverse/features/profile/providers/settings/settings_provider.dart';

// export 'package:socialverse/features/search/providers/create_subverse_provider.dart';
// export 'package:socialverse/features/search/providers/edit_subverse_provider.dart';
// export 'package:socialverse/features/search/providers/search_provider.dart';
// export 'package:socialverse/features/search/providers/subscription_provider.dart';

// export 'package:socialverse/features/home/providers/nested_provider.dart';




// Screens

// export 'package:socialverse/features/home/presentation/home_screen.dart';
// export 'package:socialverse/features/auth/presentation/login/create_username_screen.dart';
// export 'package:socialverse/features/auth/presentation/login/forgot_password_screen.dart';
// export 'package:socialverse/features/auth/presentation/login/login_screen.dart';
// export 'package:socialverse/features/auth/presentation/onboarding/onboarding_screen.dart';
// export 'package:socialverse/features/auth/presentation/sign_up/email_screen.dart';

// export 'package:socialverse/features/auth/presentation/sign_up/name_screen.dart';
// export 'package:socialverse/features/auth/presentation/sign_up/password_screen.dart';
// export 'package:socialverse/features/auth/presentation/sign_up/signup_screen.dart';
// export 'package:socialverse/features/auth/presentation/sign_up/username_screen.dart';
// export 'package:socialverse/features/auth/presentation/sign_up/verify_screen.dart';

// export 'package:socialverse/features/create/presentation/camera_screen.dart';
// export 'package:socialverse/features/create/presentation/post_screen.dart';

// export 'package:socialverse/core/presentation/notifications.dart';

// export 'package:socialverse/features/search/presentation/create_edit/create_subverse_screen.dart.dart';
// export 'package:socialverse/features/search/presentation/create_edit/edit_subverse_screen.dart';
// export 'package:socialverse/features/search/presentation/subverse/search_screen.dart';
// export 'package:socialverse/features/search/presentation/subverse/subverse_detail_screen.dart';
// export 'package:socialverse/features/search/presentation/subverse/subverse_empty_screen.dart';
// export 'package:socialverse/features/search/presentation/subverse/subverse_screen.dart';
// export 'package:socialverse/features/search/widgets/subverse_detail/subverse_detail_header.dart';
// export 'package:socialverse/features/search/widgets/subverse_detail/subverse_post_grid_item.dart';
// export 'package:socialverse/features/search/widgets/video/video_widget.dart';

// export 'package:socialverse/core/presentation/welcome_screen.dart';






