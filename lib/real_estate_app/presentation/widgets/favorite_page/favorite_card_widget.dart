import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../assets/colors.dart';
import '../../../domain/models/house_model.dart';
import '../house_icons_widget.dart';

class FavoriteCardWidget extends StatefulWidget {
  final HouseModel house;
  final Function onClosePressed;
  final String distance;

  const FavoriteCardWidget({
    required this.house,
    required this.distance,
    required this.onClosePressed,
    super.key,
  });

  @override
  State<FavoriteCardWidget> createState() => _FavoriteCardWidgetState();
}

class _FavoriteCardWidgetState extends State<FavoriteCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: SizedBox(
          height: 150,
          width: 700,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 95,
                          width: 100,
                          imageUrl: "https://intern.d-tt.nl${widget.house.image}",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '\u0024${NumberFormat("#,##0").format(widget.house.price)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'GothamSSm',
                                        fontWeight: FontWeight.w500,
                                        color: DesignSystemColors.strong,
                                      ),
                                    ),
                                    Text(
                                      "${widget.house.zip} ${widget.house.city}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'GothamSSm',
                                        fontWeight: FontWeight.w400,
                                        color: DesignSystemColors.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: HouseIconsWidget(
                                house: widget.house,
                                distance: widget.distance,
                                sizeOfFont: 10,
                                iconWidth: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => {
                      widget.onClosePressed(widget.house),
                    },
                    child: SvgPicture.asset(
                      "lib/assets/Icons/ic_close.svg",
                      color: DesignSystemColors.medium,
                      width: 25,
                      height: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
