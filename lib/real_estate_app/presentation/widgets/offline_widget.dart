import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/splash_screen_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../assets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_settings/open_settings.dart';

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
                padding: const EdgeInsets.fromLTRB(0, 180, 0, 0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "OFFLINE",
                        style: TextStyle(
                            color: DesignSystemColors.lightGray,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
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
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () => OpenSettings.openWIFISetting(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DesignSystemColors.strong,
                        ),
                        child: const Text(
                          'Connect to WiFi',
                          style: TextStyle(
                            color: DesignSystemColors.lightGray,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        )),
                        SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () => OpenSettings.openDataRoamingSetting(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DesignSystemColors.strong,
                        ),
                        child: const Text(
                          'Connect to Mobile Data',
                          style: TextStyle(
                            color: DesignSystemColors.lightGray,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        )),
                  ],
                ),
              ),
            )
          : SplashScreenWidget(),
    );
  }
}
