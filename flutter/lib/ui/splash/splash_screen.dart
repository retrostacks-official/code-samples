import 'package:customer_zimkey/constants/assets.dart';
import 'package:customer_zimkey/navigation/route_generator.dart';
import 'package:customer_zimkey/utils/helper/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  ValueNotifier<bool> loadOneTime = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.logoAnimation);
    _controller.initialize();
    _controller.play();
    _controller.addListener(() {
      if (!_controller.value.isPlaying) {
        if(!loadOneTime.value) {
          loadOneTime.value=true;
          if (HelperFunctions.checkLoggedIn()) {
            HelperFunctions.navigateToHome(context);
          } else {
            HelperFunctions.navigateToLogin(context);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the desired background color
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 1 / 1,
              child: VideoPlayer(_controller),
            ),
          ),
        ],
      ),
    );
  }
}
