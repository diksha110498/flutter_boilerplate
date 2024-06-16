import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:flutter_boilerplate/src/core/connectivity/api_constants.dart';
import 'dart:math';
import 'export.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as Timeago;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppUtils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static launchMultiMediaOpt({phoneNumber, email, whatsappNumber}) async {
    var phoneContact = phoneNumber;
    var whatsappContact = whatsappNumber;
    var emailContact = email;

    if (phoneContact != null) {
      try {
        Uri numberUri;
        numberUri = Uri(scheme: 'tel', path: phoneContact);

        if (!await launchUrl(numberUri)) throw 'Could not launch $numberUri';
      } catch (e) {
        EasyLoading.showToast("Can't make a call.");
      }
    }
    if (emailContact != null) {
      try {
        final Uri params = Uri(
          scheme: 'mailto',
          path: emailContact,
        );
        String url = params.toString();
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          print('Could not launch $url');
        }
      } catch (e) {
        EasyLoading.showToast("Something went wrong.");
      }
    }

    if (whatsappContact != null) {
      var androidUrl = "whatsapp://send?phone=$whatsappContact?text=''";
      var iosUrl = "https://wa.me/$whatsappContact?text=''";
      try {
        if (Platform.isIOS) {
          await launchUrl(Uri.parse(iosUrl));
        } else {
          await launchUrl(Uri.parse(androidUrl));
        }
      } on Exception {
        EasyLoading.showToast('WhatsApp is not installed.');
      }
    }
  }

  static getAnimationView({child}) {
    return AnimationConfiguration.staggeredList(
        position: 0,
        child: SlideAnimation(
            duration: Duration(milliseconds: 500),
            verticalOffset: 50.0,
            child: FadeInAnimation(child: child)));
  }

  static String getPriceValue(num? price) {
    return price?.toStringAsFixed(2) ?? "0.0";
  }

  static checkConvertedDate(DateTime utcTime) {
    var dateFormat =
        DateFormat("dd MMM, yyyy hh:mm aa"); // you can change the format here
    var utcDate = dateFormat
        .format(DateTime.parse(utcTime.toString())); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, false).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    return createdDate;
  }

  static Future<void> launchURL({required Uri urlLaunch}) async {
    if (!await launchUrl(urlLaunch, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $urlLaunch');
    }
  }

  static getShimmerWidget({child}) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: child ??
            Container(
              height: 50,
              width: 500,
              color: AppColors.textHeadingColor,
            ));
  }

  static getTimeAgo(date) {
    return Timeago.format(
        DateFormat("yyyy-MM-ddTHH:mm:ss.000Z").parse(date, true).toLocal());
  }

  static String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat.EEEE().format(dateTime);
    String formattedDayOfMonth = DateFormat.d().format(dateTime);
    String formattedMonth = DateFormat.MMMM().format(dateTime);

    return 'Today, $formattedDate $formattedDayOfMonth $formattedMonth';
  }

  static String formatDateTimeView(originalDateTime) {
    print("heres us t ${originalDateTime}");
    DateTime parsedDateTime =
        DateFormat('yyyy-MM-dd, h:mm a').parse(originalDateTime ?? "");

    String formattedDateTime =
        DateFormat('d MMM yyyy, h:mm a').format(parsedDateTime);

    return formattedDateTime;
  }

  static getStartEndTimeText(DateTime startTime, DateTime endTime) {
    return "${DateFormat('hh:mm a').format(startTime)} - ${DateFormat('hh:mm a').format(endTime)}";
  }

  static getScheduledForText(
      String selectedDate, String startTime, String endTime) {
    if (selectedDate.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
      DateTime date = DateFormat("yyyy-MM-dd").parse(selectedDate);
      DateTime start = DateFormat("HH:mm:ss").parse(startTime);
      DateTime end = DateFormat("HH:mm:ss").parse(endTime);
      return "${DateFormat('dd MMM yyyy').format(date)}, ${DateFormat('hh:mm a').format(start)} - ${DateFormat('hh:mm a').format(end)}";
    }
    return '';
  }

  static ratingBarBuilder(double initialrating, bool isEnable,
      {onRatingUpdate, ratingWidget, imageHeight, imageWidth}) {
    return IgnorePointer(
      ignoring: !isEnable,
      child: RatingBar.builder(
          initialRating: initialrating,
          minRating: 1,
          direction: Axis.horizontal,
          unratedColor: AppColors.ratingBarUnSelectionColor,
          allowHalfRating: false,
          itemCount: 5,
          wrapAlignment: WrapAlignment.start,
          itemSize: imageHeight ?? AppSizes.mediumIconSize,
          itemPadding: EdgeInsets.only(right: 3.0),
          itemBuilder: ratingWidget ??
              (context, _) => Image.asset(AppImages.appLogoMain,
                  height: imageHeight ?? AppSizes.extrasmallIconSize,
                  width: imageWidth ?? AppSizes.extrasmallIconWidthSize),
          onRatingUpdate: isEnable ? onRatingUpdate : (value) {}),
    );
  }

  static getAvgRatingString(double avgRating) {
    switch (avgRating.round()) {
      case 1:
        return "Needs Improvement";
      case 2:
        return "Satisfactory";
      case 3:
        return "Good";
      case 4:
        return "Great";
      case 5:
        return "Excellent";
      default:
        return "Good";
    }
  }

  static createdOnText(String createdOn, {separator = ","}) {
    if (createdOn != null && createdOn.isNotEmpty) {
      DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ss.000Z")
          .parse(createdOn, true)
          .toLocal();
      return "${DateFormat('dd MMM yyyy $separator hh:mm a').format(date)}";
    }
    return '';
  }

  static String formatDate(String dateTime, String newFormat,
      {String oldFormat = 'yyyy-MM-ddTHH:mm:ss.000Z'}) {
    // Use the intl package to format the date
    if (dateTime != null && dateTime.isNotEmpty) {
      DateTime date = DateFormat(oldFormat).parse(dateTime, true).toLocal();
      String newDate = DateFormat(newFormat).format(date);
      return newDate;
    }
    return '';
  }

  static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input; // Handle empty string
    return input[0].toUpperCase() + input.substring(1);
  }

  static createdDateText(String createdOn) {
    if (createdOn != null && createdOn.isNotEmpty) {
      DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ss.000Z")
          .parse(createdOn, true)
          .toLocal();
      return "${DateFormat('dd MMM yyyy').format(date)}";
    }
    return '';
  }

  static createdDateTime(String createdOn) {
    if (createdOn != null && createdOn.isNotEmpty) {
      DateTime date = DateFormat("yyyy-MM-ddTHH:mm:ss.000Z")
          .parse(createdOn, true)
          .toLocal();
      return "${DateFormat('hh:mm a').format(date)}";
    }
    return '';
  }

  static getFormattedDateText(DateTime selectedDate) {
    return DateFormat('dd MMM, yyyy').format(selectedDate);
  }

  static String extractPhoneNumber(String input) {
    // Define a regex pattern to match digits
    RegExp regex = RegExp(r'\d+');
    // Use the regex pattern to find all matches in the input string
    Iterable<Match> matches = regex.allMatches(input);
    // Concatenate all matched digits
    String phoneNumber = matches.map((match) => match.group(0)).join('');
    return phoneNumber;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).unfocus();
  }

  // Method to show a loading indicator
  static void showLoading(BuildContext context,
      {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16.0),
                Text(message),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget showSpinner({Color color = Colors.black}) {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color)),
    );
  }

  static Widget showPlaceholder() {
    return const Center(
      child: Text(
        'No Data Found!',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  static Widget getNetWorkImage(imageUrl, {width, height, boxFit, errorImage}) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, image, _) {
          return errorImage ??
              Shimmer.fromColors(
                  child: Container(
                    width: width,
                    height: height,
                    color: AppColors.textFieldBorderColor,
                  ),
                  baseColor: AppColors.textFieldBorderColor,
                  highlightColor: Colors.white);
        },
        placeholder: (context, string) {
          return Shimmer.fromColors(
              child: Container(
                width: width,
                height: height,
                color: AppColors.textFieldBorderColor,
              ),
              baseColor: AppColors.textFieldBorderColor,
              highlightColor: Colors.white);
        },
        width: width,
        height: height,
        fit: boxFit ?? BoxFit.contain);
  }

  // Method to hide the loading indicator
  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Method to hide the loading indicator
  static String fullAddressDetails(List<Placemark> addressList) {
    try {
      String address = '';
      String name = addressList.first.name ?? "";
      String subLocality = addressList.first.subLocality ?? "";
      String locality = addressList.first.locality ?? "";
      String administrativeArea = addressList.first.administrativeArea ?? "";
      String postalCode = addressList.first.postalCode ?? "";
      String country = addressList.first.country ?? "";
      address =
          "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
      return address;
    } catch (e) {
      print("fullAddressDetails error ${e.toString()}");
      return '';
    }
  }

  static String formatTime(DateTime dateTimeString) {
    // Format the time portion
    String time = DateFormat.jm()
        .format(dateTimeString); // 'jm' formats time as 'hh:mm a'
    return time;
  }

  // Method to open the email application
  static void sendEmail(String email) async {
    // TODO: Implement email launching using a package like url_launcher
    // Example: await launch('mailto:$email');
  }

  static String getInitials(String name) {
    List<String> nameParts = name.split(' ');
    String initials = '';

    if (nameParts.isNotEmpty) {
      initials += nameParts[0][0].toUpperCase(); // First initial

      if (nameParts.length > 1) {
        initials += nameParts.last[0].toUpperCase(); // Last initial
      }
    }

    return initials;
  }

  static Color getRandomColor(int index) {
    // Define the list of predefined colors
    final List<Color> colors = [
      const Color(0xFFdbc541),
      const Color(0xFFb7d481),
      const Color(0xFF41b0e5),
      const Color(0xFFf2a9b0),
      const Color(0xFFefb94d),
      const Color(0xFFdc8dbb),
      const Color(0xFF85c7a6),
      const Color(0xFFc692c1),
      const Color(0xFFeacea0),
      const Color(0xFFd7d7d7),
    ];

    int colorIndex = index % colors.length;
    Color selectedColor = colors[colorIndex];

    return selectedColor;
  }

  static Color? _previousColor;

  static Color getRandomColor2() {
    // Define the list of predefined colors
    final List<Color> colors = [
      const Color(0xFFdbc541),
      const Color(0xFFb7d481),
      const Color(0xFF41b0e5),
      const Color(0xFFf2a9b0),
      const Color(0xFFefb94d),
      const Color(0xFFdc8dbb),
      const Color(0xFF85c7a6),
      const Color(0xFFc692c1),
      const Color(0xFFeacea0),
      const Color(0xFFd7d7d7),
    ];

    Color randomColor;
    do {
      int randomIndex = Random().nextInt(colors.length);
      randomColor = colors[randomIndex];
    } while (randomColor == _previousColor);

    _previousColor = randomColor;

    return randomColor;
  }

  static String convertDate(DateTime dateTime) {
    String formattedDay = dateTime.day.toString();
    return '$formattedDay';
  }

  static String formatMonth(DateTime dateTime) {
    String formattedMonth = getMonthName(dateTime.month);

    return '$formattedMonth';
  }

  static DateTime truncateTime(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String getCurrentMonthShortName() {
    DateTime now = DateTime.now();
    String monthShortName = DateFormat.MMM().format(now);
    return monthShortName;
  }

  static String getCurrentYear() {
    // Get the current date and time
    DateTime now = DateTime.now();
    // Extract the year from the current date
    int currentYear = now.year;
    print('Current Year: $currentYear');
    return currentYear.toString();
  }

  static String getCurrentMonthShortNameFromDateTime(DateTime focusedDay) {
    String monthShortName = DateFormat.MMM().format(focusedDay);
    return monthShortName;
  }

  static String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static String convertJsonDate(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String getRating(double rating) {
    return rating != null ? rating.toStringAsFixed(1) : '0';
  }

  static Future<String?> openDatePicker(BuildContext context,
      {String? dateFormat}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final formattedDate =
          DateFormat(dateFormat ?? 'dd.MM.yyyy').format(picked);
      return formattedDate;
    }
    return null;
  }

  static customerInfoDialog({image, name, double? rating, address, context}) {
    DialogUtils.commonDialog(
        context,
        isDismissible: false,
        AlertDialog(
          elevation: 0.0,
          contentPadding: EdgeInsets.all(AppSizes.largePadding),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppSizes.defaultRoundedRadius)),
          content: _customerInfoView(image, name, rating, address),
        ));
  }

  static _customerInfoView(String? image, name, double? rating, address) {
    return Container(
      padding: EdgeInsets.all(AppSizes.microPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    NavigationService.goBack();
                  },
                  child: Icon((Icons.close)))
            ],
          ),
          CircleAvatar(
              maxRadius: 50.0,
              minRadius: 50.0,
              backgroundColor: AppColors.secondaryLightColor,
              child: Padding(
                  padding: EdgeInsets.all(AppSizes.microPadding),
                  child: image != null && image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(
                              AppSizes.extraLargeRoundedRadius),
                          child: AppUtils.getNetWorkImage(
                              ApiConstants.cloudFrontUrl + image,
                              boxFit: BoxFit.cover,
                              height: 80.0,
                              width: 80.0),
                        )
                      : Center(
                          child: Image.asset(
                            AppImages.userPersonIcon,
                            fit: BoxFit.cover,
                          ),
                        ))),
          SizedBox(height: AppSizes.mediumvGapSize),
          Text(name, style: AppFontStyle.getSubHeadingStyle()),
          AppUtils.ratingBarBuilder(rating ?? 0.0, false),
          SizedBox(height: AppSizes.mediumvGapSize),
          Text(
            address,
            style: AppFontStyle.getContentMediumTextStyle(
                color: AppColors.textHeadingColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Add more utility methods as needed for your app
}
