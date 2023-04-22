import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/info_page/info_widget.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/not_found_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../assets/colors.dart';
import '../../../domain/dtos/house_search_params.dart';
import '../../../domain/models/house_model.dart';
import '../../bloc/bloc/house_list_bloc.dart';
import '../house_detail_page/house_detail_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HouseListWidget extends StatefulWidget {
  final List<HouseModel> houses;
  const HouseListWidget({required this.houses});

  @override
  State<HouseListWidget> createState() => _HouseListWidgetState();
}

class _HouseListWidgetState extends State<HouseListWidget> {
  late String searchInput;
  Map<int, String> distances = {};
  Set<int> favoriteHouses = {};
  bool isSearchPressed = false;
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.houses.forEach((house) {
      if (!distances.containsKey(house.id)) {
        BlocProvider.of<HouseListBloc>(context).add(GetDistanceToHouse(
          houseId: house.id,
          lat: house.latitude.toDouble(),
          lon: house.longitude.toDouble(),
        ));
      }
    });
    // _textController.addListener(_onInputChanged);
  }
/*
  void _onInputChanged(){
    setState(() {
    if (_textController.text.isNotEmpty) {
      isInputEmpty = false;
    } else {
      isInputEmpty = true;
    }
  });
  }
  */

  @override
  Widget build(BuildContext context) {
    return BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if (state is DistanceLoaded) {
          setState(() {
            print(state.distance);
            distances[state.houseId] = state.distance.toStringAsFixed(1);
          });
        }
      },
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 0, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('DTT REAL ESTATE',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'GothamSSm',
                    fontWeight: FontWeight.w700,
                    color: DesignSystemColors.strong,
                  )),
            ),
          ),
          Center(
            child: SizedBox(
              width: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: TextField(
                  controller: _textController,
                  onChanged: (value) {
                    if(_textController.text.isEmpty) setState((){isSearchPressed = false;});
                    searchInput = value;
                  },
                  onSubmitted: (_) {
                    getSpecificHouses();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search for a home',
                    filled: true,
                    fillColor: DesignSystemColors.darkGray,
                    suffixIcon: IconButton(
                      icon: isSearchPressed
                          ? SvgPicture.asset("lib/assets/Icons/ic_close.svg")
                          : SvgPicture.asset(
                              "lib/assets/Icons/ic_search.svg",
                              color: DesignSystemColors.medium,
                            ),
                      onPressed: isSearchPressed
                          ? () => {
                              setState(() {
                                  isSearchPressed = false;
                                  _textController.clear();
                                })
                              }
                          : () => {
                                getSpecificHouses(),
                                setState(() {
                                  isSearchPressed = true;
                                })
                              },
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.houses.length,
            itemBuilder: (context, index) {
              final house = widget.houses[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HouseDetailWidget(
                              houseModel: house,
                              distance: distances.containsKey(house.id)
                                  ? '${distances[house.id]} km'
                                  : '2,5km'),
                        ));
                  },
                  child: Center(
                    child: SizedBox(
                      height: 150,
                      width: 700,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                                  imageUrl:
                                      "https://intern.d-tt.nl${house.image}",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 50, 0),
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 0, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '\u0024${NumberFormat("#,##0").format(house.price)}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'GothamSSm',
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    DesignSystemColors.strong,
                                              ),
                                            ),
                                            Text(
                                              "${house.zip} ${house.city}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'GothamSSm',
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    DesignSystemColors.medium,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (favoriteHouses
                                                      .contains(house.id)) {
                                                    favoriteHouses
                                                        .remove(house.id);
                                                  } else {
                                                    favoriteHouses
                                                        .add(house.id);
                                                  }
                                                });
                                                BlocProvider.of<HouseListBloc>(
                                                        context)
                                                    .add(AddFavorite(
                                                        houseModel: house));
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: favoriteHouses
                                                        .contains(house.id)
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 5),
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
                                            house.bedrooms.toString(),
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
                                            house.bathrooms.toString(),
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
                                            house.size.toString(),
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
                                            distances.containsKey(house.id)
                                                ? '${distances[house.id]} km'
                                                : '2,5km',
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void getSpecificHouses() {
    TextEditingController().clear();
    String? city;
    String? zip;

    String searchInputUpper = searchInput.toUpperCase();

    if (RegExp(r'^[A-Z0-9]{2,8}$').hasMatch(searchInputUpper)) {
      if (searchInputUpper.length < 6) {
        zip = searchInputUpper;
      } else {
        zip = searchInputUpper.substring(0, 4) +
            ' ' +
            searchInputUpper.substring(4, 6);
      }
    } else {
      city = searchInput;
    }

    List<String> inputParts = searchInputUpper.split(' ');
    if (RegExp(r'^\d{4}[A-Z]{2}$').hasMatch(searchInput)) {
      zip = searchInputUpper.substring(0, 4) +
          ' ' +
          searchInputUpper[0].substring(4, 6);
      city = '';
    }
    if (RegExp(r'^\d{4}\s[A-Z]{2}$').hasMatch(searchInput)) {
      zip = searchInputUpper;
      city = '';
    }
    if (inputParts.length >= 2 &&
        RegExp(r'^\d{4}\s[A-Z]{2}$')
            .hasMatch(inputParts[0] + ' ' + inputParts[1])) {
      zip = inputParts[0] + ' ' + inputParts[1];
      city = inputParts.sublist(2).join(' ').trim();
    } else if (inputParts.length >= 2 &&
        RegExp(r'^\d{4}[A-Z]{2}$').hasMatch(inputParts[0])) {
      zip = inputParts[0].substring(0, 4) + ' ' + inputParts[0].substring(4, 6);
      city = inputParts.sublist(1).join(' ').trim();
    }

    BlocProvider.of<HouseListBloc>(context).add(GetSpecificHouses(
        houseSearchParams: HouseSearchParams(city: city, zip: zip)));
  }
}
