import 'dart:async';

import 'package:customer_zimkey/data/model/services/single_service_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../data/model/booking_slot/booking_slots_response.dart';
import '../../data/model/data_handling/generic/generic_class.dart';
import '../../data/model/data_handling/state_model/state_model.dart';
import '../../navigation/route_generator.dart';
import '../object_factory.dart';

class HelperFunctions {
  static final dateTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ssZ");

  static String getDateTimeForAPI(DateTime? dateTime) {
    if (dateTime != null) {
      dateTime = dateTime.toUtc();
      return dateTimeFormat.format(dateTime).toString();
    } else {
      return "";
    }
  }

  static String capitalize(String s) {
    if (s.isNotEmpty) {
      return s[0].toUpperCase() + s.substring(1);
    } else {
      return "";
    }
  }

  static void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static KeyboardActionsConfig buildConfig({required BuildContext context, required List<FocusNode> focusNodeList}) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
        focusNodeList.length,
        (index) => KeyboardActionsItem(
          focusNode: focusNodeList[index],
        ),
      ),
    );
  }

  static bool checkLoggedIn() {
    if (ObjectFactory().prefs.isLoggedIn()!) {
      return true;
    } else {
      return false;
    }
  }

  static navigateToLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.authScreen, (route) => false);
  }

  static navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.homeScreen, (route) => false, arguments: 0);
  }

  static navigateToComingSoon(BuildContext context) {
    Navigator.pushNamed(context, RouteGenerator.comingSoonScreen);
  }

  static navigateToBookings(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.homeScreen, (route) => false, arguments: 2);
  }

  static navigateToLocationSelection(BuildContext context) {
    if (ObjectFactory().prefs.getSelectedLocation() != null) {
      navigateToHome(context);
    } else {
      Navigator.pushNamedAndRemoveUntil(context, RouteGenerator.locationSelectionScreen, (route) => false);
    }
  }

  /// service detail page, schedule section
  static String filterTimeSlot(GetServiceBookingSlot serviceBookingSlot) {
    DateFormat format = DateFormat.Hm();
    String output =
        '${format.format(serviceBookingSlot.start.toLocal())} - ${format.format(serviceBookingSlot.end.toLocal())}';
    return output;
  }

  static Future<void> launchURL(String url) async {
    await canLaunchUrlString(url) ? await launchURL(url) : throw 'Could not launch $url';
  }

  static Function debounce(Function() action) {
    Timer? timer;
    return () {
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(const Duration(milliseconds: 500), action);
    };
  }

  // static StateModel handleResponse<T>(Response? response) {
  static ResponseModel handleResponse<T>(QueryResult response) {
    // if (response!.statusCode == ResponseCode.success || response.statusCode == ResponseCode.created) {
    if (!response.hasException) {
      // Logger().i(response.data);
      return ResponseModel<T>.success(Generic.fromJson<T>(response.data));
    } else {
      // return StateModel<String>.error(checkErrorResponseCode(response));
      Logger().e(response.exception);
      if (response.exception != null) {
        return ResponseModel<OperationException>.error(response.exception!);
        // return StateModel<String>.error("The OTP entered is incorrect. Please enter correct OTP");
      } else {
        return ResponseModel<String>.error("Something went wrong");
      }
    }
  }

  ///for rest api
  // static String checkErrorResponseCode(Response response) {
  //   switch (response.status) {
  //     case ResponseCode.unAuthorised:
  //       showToast("Session Completed.. Please login.");
  //       throw UnauthorisedException();
  //
  //     case ResponseCode.notFound:
  //       return "Not Found";
  //
  //     case ResponseCode.deviceAlreadyAssignedToSameAccount:
  //       showToast("Device Already Assigned to your account");
  //       throw DeviceAlreadyAssignedToSameAccountException();
  //
  //     case ResponseCode.deviceAlreadyAssignedToOtherAccount:
  //       showToast("Device Already Assigned to a different account");
  //       throw DeviceAlreadyAssignedToOtherAccountException();
  //
  //     case ResponseCode.invalidButton:
  //       showToast("Invalid Button... try again with valid QR");
  //       throw InvalidButtonException();
  //
  //     case ResponseCode.internalServerError:
  //     default:
  //       throw FetchDataException(
  //         'Error occurred while Communication with Server with StatusCode : ${response.statusCode}',
  //       );
  //   }
  // }

  static String toMonth(int val) {
    switch (val) {
      case 1:
        {
          return "Jan";
        }
      case 2:
        {
          return "Feb";
        }
      case 3:
        {
          return "Mar";
        }
      case 4:
        {
          return "Apr";
        }
      case 5:
        {
          return "May";
        }
      case 6:
        {
          return "Jun";
        }
      case 7:
        {
          return "Jul";
        }
      case 8:
        {
          return "Aug";
        }
      case 9:
        {
          return "Sep";
        }
      case 10:
        {
          return "Oct";
        }
      case 11:
        {
          return "Nov";
        }
      default:
        {
          return "Dec";
        }
    }
  }

  static String formatTime(int val) {
    if (val > 12) {
      return ("PM");
    } else {
      return ("AM");
    }
  }

  static String formatHour(int val) {
    if (val < 13) {
      return (val.toString());
    } else {
      return (val - 12).toString();
    }
  }

  static bool isValidEmail(String mail) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(mail);
  }

  static int calculateOffPercentage(String price, String listPrice) {
    if (double.tryParse(listPrice)!.round() > 0) {
      return 100 - ((double.tryParse(price)!.round() / double.tryParse(listPrice)!.round()) * 100).round();
    } else {
      return 0;
    }
  }

  static String moneyFormat(String price) {
    var value = price;
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      return value;
    }
    return value;
  }

  static bool isOthersSelected(List<Requirement> selectedRequirement) {
    var isOtherSelected = false;
    for (var element in selectedRequirement) {
      if (element.title.toLowerCase() == "others" || element.title.toLowerCase() == "other") {
        isOtherSelected = true;
        break;
      }
    }
    return isOtherSelected;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight({required BuildContext context, double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  static double screenWidth({required BuildContext context, double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

// static Widget lottieProgressIndicator({required double height}){
//   return SizedBox(
//       height: height*.6,
//       child: Center(child: SizedBox(height: 150,width: 150,
//           child: Lottie.asset(Assets.healthCareLoaderGif))));
// }
// static Widget lottieNoResultFound(){
//   return Lottie.asset(Assets.noResultFoundGif);
// }
// static Widget lottieCartEmpty(){
//   return Lottie.asset(Assets.cartEmptyGif);
// }
// static Widget lottieNoBookingFound(){
//   return Lottie.asset(Assets.noBookingFoundGif);
// }
// static Widget lottieComingSoon(){
//   return Lottie.asset(Assets.comingSoonGif);
// }
// static Widget lottieLoginAnimGif(){
//   return Lottie.asset(Assets.loginAnimGif);
// }
// static Widget lottieOrderSuccess(){
//   return Lottie.asset(Assets.orderSuccessGif);
// }
}

// Future<File> downloadImage(
//     String dir, String filename, String networkImageUrl) async {
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   File file = new File('$dir/$filename');
//   file.open(mode: FileMode.write);
//
//   print('file not found downloading from server');
//   Dio dio = new Dio(new BaseOptions(responseType: ResponseType.bytes));
// //  Response fileDownloadResponse =
// //      await dio.download(networkImageUrl, file.path);
//   var request = await dio.get(networkImageUrl);
//   var bytes = await request.data; //close();
//   await file.writeAsBytes(bytes);
//   print(file.path);
//   return file;
// }
