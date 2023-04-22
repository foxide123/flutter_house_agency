import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/assets/colors.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/splash_screen_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfflineWidget extends StatelessWidget {
  final bool isOffline;
  
  const OfflineWidget({required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isOffline ? MediaQuery.of(context).size.height : 0.0,
      color: isOffline ? DesignSystemColors.red : Colors.transparent,
      child: isOffline
          ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Column(
                children: [
                  const Center(
                      child: Text(
                        "OFFLINE",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Center(
                      child: SvgPicture.asset(
                        "lib/assets/Images/no_internet.svg",
                        height: 100,
                        width: 100,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
          : SplashScreenWidget(),
    );
  }
}