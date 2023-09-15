import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import '../../utils/helper/helper_widgets.dart';


class BottomNavigation extends StatefulWidget {
  final int currentIndex;

  const BottomNavigation({Key? key, this.currentIndex = 0}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  bool showSearch = false;
  bool isFav = false;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      isFav = false;
    });
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.zimkeyOrange,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );

  final List<Widget> _children = [
   const ComingSoon(),
   const ComingSoon(),
   const ComingSoon(),
   const ComingSoon(),
  ];


  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: _children[_currentIndex]),
        bottomNavigationBar: customBottomNav(),
      ),
    );
  }

  Widget customBottomNav() {
    return Container(
      height: 65,
      decoration: const BoxDecoration(
        color: AppColors.zimkeyBottomNavGrey,
        boxShadow: [
          BoxShadow(
            color: AppColors.zimkeyLightGrey,
            offset: Offset(2.0, -3.0),
            blurRadius: 5.0,
          )
        ],
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomNavButton(
            'assets/images/graphics/hometab_icon.svg',
            // 'assets/images/icons/logoNoFill.svg',
            0,
          ),
          bottomNavButton(
            'assets/images/icons/newIcons/grid.svg',
            1,
          ),
          bottomNavButton(
            'assets/images/icons/newIcons/bookingsTab.svg',
            2,
          ),
          bottomNavButton(
            'assets/images/user.svg',
            3,
          ),
        ],
      ),
    );
  }

  Widget bottomNavButton(String icon, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () async {
          onTabTapped(index);
          // await getUserMutation();
        },
        child: SvgPicture.asset(
          icon,
          height: index == 0 ? 29 : 24,
          colorFilter: ColorFilter.mode(_currentIndex == index ? AppColors.zimkeyOrange : AppColors.zimkeyDarkGrey, BlendMode.srcIn),
        ),
      ),
    );
  }
}
class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
  }
}

