import 'package:coner_client/configs/router/page_transition.dart';
import 'package:coner_client/configs/router/route_names.dart';
import 'package:coner_client/screens/bottom_bar/bottom_bar.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/inquiry/inquiry_screen.dart';
import 'package:coner_client/screens/bottom_bar/pages/my_page/notice/notice_screen.dart';
import 'package:coner_client/screens/sign_in/sign_in_screen.dart';
import 'package:coner_client/screens/sign_up/sign_up_screen.dart';
import 'package:coner_client/screens/sign_up/sign_up_success_screen.dart';
import 'package:coner_client/screens/splash/splash_screen.dart';
import 'package:coner_client/screens/update_request/update_request_screen.dart';
import 'package:go_router/go_router.dart';

import '../../screens/add_request/add_request_screen.dart';
import '../../screens/add_request/request_image_example/request_example_image_screen.dart';
import '../../screens/bottom_bar/pages/my_page/privacy_policy/privacy_policy_screen.dart';
import '../../screens/profile_update/profile_update_phone/profile_update_phone_screen.dart';
import '../../screens/profile_update/profile_update_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: RouteNames.splash,
        path: '/',
        pageBuilder: (context, state) =>
            PageTrainsition.fadeTransition(state, const SplashScreen()),
      ),
      GoRoute(
        name: RouteNames.main,
        path: "/${RouteNames.main}",
        pageBuilder: (context, state) => PageTrainsition.fadeTransition(state, const BottomBar()),
        routes: [
          GoRoute(
            name: RouteNames.addRequest,
            path: RouteNames.addRequest,
            builder: (context, state) => AddRequestScreen(),
            routes: [
              GoRoute(
                name: RouteNames.requestExampleImage,
                path: RouteNames.requestExampleImage,
                builder: (context, state) => const RequestExampleImageScreen(),
              ),
            ],
          ),
          GoRoute(
            name: RouteNames.updateRequest,
            path: RouteNames.updateRequest,
            builder: (context, state) => UpdateRequestScreen(),
          ),
          GoRoute(
            name: RouteNames.profileUpdate,
            path: RouteNames.profileUpdate,
            builder: (context, state) => const ProfileUpdateScreen(),
            routes: [
              GoRoute(
                name: RouteNames.profileUpdatePhone,
                path: RouteNames.profileUpdatePhone,
                builder: (context, state) => const ProfileUpdatePhoneScreen(),
              ),
            ],
          ),
          GoRoute(
            name: RouteNames.signIn,
            path: RouteNames.signIn,
            builder: (context, state) => const SignInScreen(),
            routes: [
              GoRoute(
                name: RouteNames.signUp,
                path: RouteNames.signUp,
                builder: (context, state) => const SignUpScreen(),
              ),
            ],
          ),
          GoRoute(
            name: RouteNames.inquiry,
            path: RouteNames.inquiry,
            builder: (context, state) => const InquiryScreen(),
          ),
          GoRoute(
            name: RouteNames.notice,
            path: RouteNames.notice,
            builder: (context, state) => const NoticeScreen(),
          ),
          GoRoute(
            name: RouteNames.privacyPolicy,
            path: RouteNames.privacyPolicy,
            builder: (context, state) => const PrivacyPolicyScreen(),
          ),
        ],
      ),
      GoRoute(
        name: RouteNames.signUpSuccess,
        path: "/${RouteNames.signUpSuccess}",
        builder: (context, state) => const SignUpSuccessScreen(),
      ),
    ],
    debugLogDiagnostics: true, // route debug log 출력
  );
}
