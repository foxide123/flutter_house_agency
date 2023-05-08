import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../assets/colors.dart';
import '../../domain/models/house_model.dart';

class HouseIconsWidget extends StatefulWidget {
  final HouseModel house;
  final double iconWidth;
  final double sizeOfFont;
  final String distance;

  const HouseIconsWidget({
    required this.house,
    required this.distance,
    required this.iconWidth,
    required this.sizeOfFont,
    super.key,
  });

  @override
  State<HouseIconsWidget> createState() => _HouseIconsWidgetState();
}

class _HouseIconsWidgetState extends State<HouseIconsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "lib/assets/Icons/ic_bed.svg",
          color: DesignSystemColors.medium,
          width: widget.iconWidth,
        ),
        const SizedBox(width: 2),
        Text(
          widget.house.bedrooms.toString(),
          style:  TextStyle(
            fontSize: widget.sizeOfFont,
            fontFamily: 'GothamSSm',
            fontWeight: FontWeight.w400,
            color: DesignSystemColors.medium,
          ),
        ),
        const SizedBox(width: 10),
        SvgPicture.asset(
          "lib/assets/Icons/ic_bath.svg",
          color: DesignSystemColors.medium,
          width: widget.iconWidth,
        ),
        const SizedBox(width: 2),
        Text(
          widget.house.bathrooms.toString(),
          style: TextStyle(
            fontSize: widget.sizeOfFont,
            fontFamily: 'GothamSSm',
            fontWeight: FontWeight.w400,
            color: DesignSystemColors.medium,
          ),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          "lib/assets/Icons/ic_layers.svg",
          color: DesignSystemColors.medium,
          width: widget.iconWidth,
        ),
        const SizedBox(width: 2),
        Text(
          widget.house.size.toString(),
          style: TextStyle(
            fontSize: widget.sizeOfFont,
            fontFamily: 'GothamSSm',
            fontWeight: FontWeight.w400,
            color: DesignSystemColors.medium,
          ),
        ),
        const SizedBox(width: 6),
        SvgPicture.asset(
          "lib/assets/Icons/ic_location.svg",
          color: DesignSystemColors.medium,
          width: widget.iconWidth,
        ),
        const SizedBox(width: 2),
        Text(
          widget.distance,
          style: TextStyle(
            fontSize: widget.sizeOfFont,
            fontFamily: 'GothamSSm',
            fontWeight: FontWeight.w400,
            color: DesignSystemColors.medium,
          ),
        ),
      ],
    );
  }
}
