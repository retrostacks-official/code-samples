
import 'package:customer_zimkey/utils/helper/helper_widgets.dart';
import 'package:flutter/material.dart';

import '../ui/bottom_navigation/bottom_navigation_screen.dart';
import '../ui/services/service_details_screen.dart';
import '../ui/splash/splash_screen.dart';

class RouteGenerator {
  RouteGenerator._();

  static const initialScreen = '/';
  static const splashScreen = '/splash';
  static const authScreen = '/auth';
  static const userRegisterScreen = '/user_register';
  static const homeScreen = '/home';
  static const serviceDetailsScreen = '/service_details';
  static const bookingListScreen = '/booking_list';
  static const profileScreen = '/profile';
  static const addAddressScreen = '/add_address';
  static const addAddressScreenCopy = '/add_address_copy';
  static const bookingSuccessScreen = '/booking_success';
  static const customerSupportScreen = '/customer_support';
  static const faqScreen = '/faq';
  static const htmlViewerScreen = '/html_viewer';
  static const locationSelectionScreen = '/location_selection';
  static const comingSoonScreen = '/coming_soon';
  static const editProfileScreen = '/edit_profile';
  static const addressListScreen = '/address_list';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());


      case homeScreen:
        final int index = settings.arguments as int;
        return animatedRoute(BottomNavigation(currentIndex: index,));


      case comingSoonScreen:
        return  _comingSoonRoute();



      case serviceDetailsScreen:
        final String id = settings.arguments as String;
        return animatedRoute(ServiceDetailsScreen(
          id: id,
        ));


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> normalRoute(Widget screenName) {
    return MaterialPageRoute(builder: (_) => screenName);
  }

  static PageRouteBuilder animatedRoute(Widget screenName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screenName,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeIn;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black38),
          foregroundColor: Colors.white,
          title: const Text(""),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SizedBox(
            height: 200,
            width: 250,
            child: HelperWidgets.errorWidget()
          ),
        ),
      );
    });
  }
  static Route<dynamic> _comingSoonRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black38),
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: SizedBox(
            height: 200,
            width: 250,
            child: HelperWidgets.lottieComingSoon()
          ),
        ),
      );
    });
  }
}
