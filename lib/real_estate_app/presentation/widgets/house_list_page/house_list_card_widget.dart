import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../../../assets/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../bloc/bloc/house_list_bloc.dart';
import '../../../domain/models/house_model.dart';

class HouseListCardWidget extends StatefulWidget {
  final HouseModel house;
  final Function onTap;
  final bool isFavorite;
  final String distance;

  const HouseListCardWidget({
    required this.house,
    required this.onTap,
    required this.isFavorite,
    required this.distance,
    super.key,
  });

  @override
  State<HouseListCardWidget> createState() => _HouseListCardWidgetState();
}

class _HouseListCardWidgetState extends State<HouseListCardWidget> {

  @override
  void initState() {
    super.initState();
  }
  
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
            child: Padding(
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
                                GestureDetector(
                                  onTap: () => {
                                    widget.onTap(widget.house.id),
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: widget.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "lib/assets/Icons/ic_bed.svg",
                                color: DesignSystemColors.medium,
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.house.bedrooms.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'GothamSSm',
                                  fontWeight: FontWeight.w400,
                                  color: DesignSystemColors.medium,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SvgPicture.asset(
                                "lib/assets/Icons/ic_bath.svg",
                                color: DesignSystemColors.medium,
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.house.bathrooms.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'GothamSSm',
                                  fontWeight: FontWeight.w400,
                                  color: DesignSystemColors.medium,
                                ),
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                "lib/assets/Icons/ic_layers.svg",
                                color: DesignSystemColors.medium,
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                widget.house.size.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'GothamSSm',
                                  fontWeight: FontWeight.w400,
                                  color: DesignSystemColors.medium,
                                ),
                              ),
                              const SizedBox(width: 6),
                              SvgPicture.asset(
                                "lib/assets/Icons/ic_location.svg",
                                color: DesignSystemColors.medium,
                                width: 16,
                                height: 16,
                              ),
                              Text(
                                widget.distance,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'GothamSSm',
                                  fontWeight: FontWeight.w400,
                                  color: DesignSystemColors.medium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
