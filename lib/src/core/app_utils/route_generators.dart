import 'package:flutter/cupertino.dart';import '../../../modules/authentication_module/ui/login_screen.dart';
import '../../../modules/static_page_module/ui/static_page.dart';
import '../../splash/splash_screen.dart';
import 'export.dart';

class RoutesGenerator {
  static const String initalRoute = '/';
  static const String bookCleanerRoute = '/bookCleaner';
  static const String mainDashboardRoute = '/mainDashboard';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String otpRoute = '/otp';
  static const String customerProfileSetupScreenRoute =
      '/customerProfileSetupScreen';
  static const String staticPageScreenRoute = '/staticPageScreen';
  static const String customerProfileRoute = '/customerProfileRoute';
  static const String searchLocationRoute = '/searchLocationRoute';
  static const String searchProvidersRoute = '/searchProvidersRoute';
  static const String confirmBookingRoute = '/confirmBookingRoute';
  static const String couponListRoute = '/couponListRoute';
  static const String createAccountRoute = '/createAccountRoute';
  static const String personalDetailRoute = '/personalDetailRoute';
  static const String generaInformationRoute = '/generaInformationRoute';
  static const String workExperienceRoute = '/workExperienceRoute';
  static const String basicSkillTestRoute = '/basicSkillTestRoute';
  static const String identificationProofRoute = '/identificationProofRoute';
  static const String agreementRoute = '/agreementRoute';
  static const String stripWebViewRoute = '/stripWebViewRoute';
  static const String bankStripWebViewRoute = '/bankStripWebViewRoute';
  static const String bookingDetailRoute = '/bookingDetailRoute';
  static const String spProfileBookingDetailRoute =
      '/spProfileBookingDetailRoute';
  static const String selectAddressRoute = '/selectAddressRoute';
  static const String addAddressScreenRoute = '/addAddressScreen';
  static const String enquiryListScreenRoute = '/enquiryListScreenRoute';
  static const String enquiryDetailScreenRoute = '/enquiryDetailScreenRoute';
  static const String contactusScreenRoute = '/contactusScreenRoute';
  static const String faqScreenRoute = '/faqScreenRoute';
  static const String referAndEarnScreenRoute = '/referAndEarnScreenRoute';
  static const String cleanerProfileViewScreen = '/cleanerProfileViewScreen';
  static const String profileStatusScreen = '/profileStatusScreen';
  static const String ratingReviewListScreen = '/ratingReviewListScreen';
  static const String createRatingScreen = '/createRatingScreen';
  static const String spRatingReviewScreen = '/spRatingReviewScreen';
  static const String sPBookingDetailsScreen = '/sPBookingDetailsScreen';
  static const String userManualScreen = '/userManualScreen';
  static const String addRatingToCustomerScreen = '/addRatingToCustomerScreen';
  static const String customerRatingViewScreen = '/customerRatingViewScreen';
  static const String spProfileScreen = '/spProfileScreen';
  static const String availabilityScreen = '/availabilityScreen';
  static const String payoutScreen = '/payoutScreen';
  static const String rebookConfirmScreen = '/rebookConfirmScreen';
  static const String multiBrandScreen = '/multiBrandScreen';
  static const String comingSoonScreen = '/comingSoonScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case initalRoute:
        return CupertinoPageRoute(
            builder: (_) => SpinImageAnimation(), settings: settings);
      case loginRoute:
        return CupertinoPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR: Page not found'),
        ),
      );
    });
  }
}
