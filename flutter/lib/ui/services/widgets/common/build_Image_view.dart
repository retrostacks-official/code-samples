import 'package:customer_zimkey/constants/colors.dart';
import 'package:customer_zimkey/ui/services/bloc/services_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../utils/helper/helper_functions.dart';
import 'service_thumbnail.dart';


class BuildImageView extends StatelessWidget {
  final SingleServiceLoaded state;
  const BuildImageView({Key? key,required this.state}) : super(key: key);
  // static double imageHeight = 0;
  @override
  Widget build(BuildContext context) {
    // imageHeight = HelperFunctions.screenHeight(context: context, dividedBy: 2);
    return Stack(
      children: [
        ServiceThumbnail(medias:state.serviceResponse.getService.medias),
        Positioned(
            top: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back when back button is tapped
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 0.8,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,// Semi-transparent color towards the edges
                    ],
                    stops: const [0.0,0.6], // Adjust stops for desired gradient effect
                  ),
                ),
                child:  const Icon(
                  Icons.arrow_back,
                  color: AppColors.zimkeyBlack,
                ),
              ),
            ))
      ],
    );
  }
}
