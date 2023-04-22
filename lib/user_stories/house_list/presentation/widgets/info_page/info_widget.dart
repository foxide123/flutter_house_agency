import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../assets/colors.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String longAboutText =
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempus convallis consequat. Donec vehicula diam nisl, a facilisis leo blandit at. Duis cursus bibendum ex, id iaculis libero porttitor eget. Duis vel ex id diam molestie venenatis. Mauris rhoncus leo tortor. Mauris feugiat sem eget massa dapibus, sed placerat quam tincidunt. Nunc sit amet ex in orci mollis lobortis ac nec erat.''';
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 50, 15, 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height/2-100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ABOUT',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'GothamSSm',
                  fontWeight: FontWeight.w700,
                  color: DesignSystemColors.strong,
                )),
            Text(longAboutText,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'GothamSSm',
                  fontWeight: FontWeight.w400,
                  color: DesignSystemColors.light,
                )),
            const Text('Design and Development',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'GothamSSm',
                  fontWeight: FontWeight.w700,
                  color: DesignSystemColors.strong,
                )),
            Row(
              children: [
                Image.asset('lib/assets/Images/dtt_banner/ldpi/dtt_banner.png'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('by DTT',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w500,
                            color: DesignSystemColors.strong,
                          )),
                      InkWell(
                        child: const Text('d-tt.nl',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'GothamSSm',
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            )),
                        onTap: () => launchUrl(Uri.parse('https://www.d-tt.nl/')),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
