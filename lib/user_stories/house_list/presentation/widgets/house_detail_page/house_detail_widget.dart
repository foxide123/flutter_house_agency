import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/assets/colors.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/models/house_model.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/house_detail_page/google_maps_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../bloc/bloc/house_list_bloc.dart';

class HouseDetailWidget extends StatefulWidget {
  final HouseModel houseModel;
  final String distance;

  const HouseDetailWidget({
    super.key,
    required this.houseModel,
    required this.distance,
  });

  @override
  State<HouseDetailWidget> createState() => _HouseDetailWidgetState();
}

class _HouseDetailWidgetState extends State<HouseDetailWidget> {
  

  @override
  Widget build(BuildContext context) {
    /*Material is used because in HouseListWidget there is
    InkWell widget which requires Material widget to render properly*/
    return Material(
      /*Expanded is used to be able to scroll down without
      any overflow errors*/
      child: Expanded(
        child: Builder(builder: (newContext) {
          return SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(height: 1000),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://intern.d-tt.nl" + widget.houseModel.image,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),

                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("lib/assets/Icons/ic_back.svg",
                          width: 40,
                          height: 40,
                          color: DesignSystemColors.darkGray),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              //1-3 digits before ','
                              '\u0024${NumberFormat("#,##0").format(widget.houseModel.price)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'GothamSSm',
                                fontWeight: FontWeight.w700,
                                color: DesignSystemColors.strong,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "lib/assets/Icons/ic_bed.svg",
                                  color: DesignSystemColors.medium,
                                  width: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.houseModel.bedrooms.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GothamSSm',
                                    fontWeight: FontWeight.w400,
                                    color: DesignSystemColors.medium,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  "lib/assets/Icons/ic_bath.svg",
                                  color: DesignSystemColors.medium,
                                  width: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.houseModel.bathrooms.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GothamSSm',
                                    fontWeight: FontWeight.w400,
                                    color: DesignSystemColors.medium,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  "lib/assets/Icons/ic_layers.svg",
                                  color: DesignSystemColors.medium,
                                  width: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.houseModel.size.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GothamSSm',
                                    fontWeight: FontWeight.w400,
                                    color: DesignSystemColors.medium,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SvgPicture.asset(
                                  "lib/assets/Icons/ic_location.svg",
                                  color: DesignSystemColors.medium,
                                  width: 22,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.distance,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'GothamSSm',
                                    fontWeight: FontWeight.w400,
                                    color: DesignSystemColors.medium,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w500,
                            color: DesignSystemColors.strong,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.houseModel.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w300,
                            color: DesignSystemColors.medium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'GothamSSm',
                            fontWeight: FontWeight.w500,
                            color: DesignSystemColors.strong,
                          ),
                        ),
                        SizedBox(height: 20),
                        GoogleMapsWidget(
                          lat: widget.houseModel.latitude.toDouble(),
                          lon: widget.houseModel.longitude.toDouble(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
