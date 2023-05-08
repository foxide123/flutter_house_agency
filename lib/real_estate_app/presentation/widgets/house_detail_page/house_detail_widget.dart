import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/house_detail_page/google_maps_widget.dart';
import '../../../../assets/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../bloc/bloc/house_list_bloc.dart';
import '../../../domain/models/house_model.dart';
import '../offline_widget.dart';
import 'package:sizer/sizer.dart';

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
  bool isMapVisible = true;
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    /*Material is used because in HouseListWidget there is
    InkWell widget which requires Material widget to render properly*/
    return isOnline? (
      kIsWeb ? webLayout(screenWidth):androidLayout()) : OfflineWidget(isOffline: true);
  }

  Widget webLayout(screenWidth){
    return Material(
      /*Expanded is used to be able to scroll down without
        any overflow errors*/
      child: Expanded(
        child: Builder(builder: (newContext) {
          return SingleChildScrollView(
            child: Padding(
              padding: screenWidth>1000 ? EdgeInsets.fromLTRB(27.w,0,27.w,0) : EdgeInsets.fromLTRB(13.w,0,13.w,0),
              child: sharedLayout(),
            ),
          );
        }),
      ),
    );
  }

  Widget androidLayout(){
    return Material(
      /*Expanded is used to be able to scroll down without
        any overflow errors*/
      child: Expanded(
        child: Builder(builder: (newContext) {
          return SingleChildScrollView(
            child: sharedLayout()
          );
        }),
      ),
    );
  }

  Widget sharedLayout(){
    return Stack(
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
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isMapVisible = !isMapVisible;
                            });
                            // await Future.delayed(Duration(milliseconds: 50));
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("lib/assets/Icons/ic_back.svg",
                              width: 40,
                              height: 40,
                              color: DesignSystemColors.darkGray),
                        ),
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
                          isMapVisible
                              ? GoogleMapsWidget(
                                  lat: widget.houseModel.latitude.toDouble(),
                                  lon: widget.houseModel.longitude.toDouble(),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
  }
}
