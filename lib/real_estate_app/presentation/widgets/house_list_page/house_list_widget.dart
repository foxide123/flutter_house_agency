import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../../assets/colors.dart';
import '../../../bloc/bloc/house_list_bloc.dart';
import '../../../domain/dtos/house_search_params.dart';
import '../../../domain/models/house_model.dart';
import '../favorite_page/favorite_notifier.dart';
import '../house_detail_page/house_detail_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../search_widget.dart';
import 'house_list_card_widget.dart';
import 'package:sizer/sizer.dart';

class HouseListWidget extends StatefulWidget {
  final List<HouseModel> houses;

  const HouseListWidget({
    required this.houses,
  });

  @override
  State<HouseListWidget> createState() => _HouseListWidgetState();
}

class _HouseListWidgetState extends State<HouseListWidget> {
  late String searchInput;
  Map<int, String> distances = {};

  bool isSearchPressed = false;
  final _textController = TextEditingController();
  final favoriteHouses = [];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HouseListBloc>(context).add(GetFavorites());
    BlocProvider.of<HouseListBloc>(context)
        .add(GetDistancesToHouses(houses: widget.houses));

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
    final favoriteHouses = Provider.of<FavoriteHouses>(context);

    return BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if (state is DistanceLoaded) {
          setState(() {
            distances = state.distances;
          });
        }
        if (state is FavoritesRetrieved) {
          setState(() {
            List<HouseModel> houses = state.houses;
            houses
                .forEach((house) => favoriteHouses.addFavoriteHouse(house.id));
          });
        }

        if (state is FavoriteAdded) {
          setState(() {
            favoriteHouses.addFavoriteHouse(state.house.id);
          });
        }
        if (state is FavoriteRemoved) {
          setState(() {
            favoriteHouses.removeFavoriteHouse(state.house.id);
          });
        }
      },
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const SafeArea(
                child: Padding(
                  padding: kIsWeb ? EdgeInsets.fromLTRB(0, 40, 0, 0): EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Text('DTT REAL ESTATE',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'GothamSSm',
                        fontWeight: FontWeight.w700,
                        color: DesignSystemColors.strong,
                      )),
                ),
              ),
              SizedBox(height: 20),
              SearchWidget(
                  controller: _textController,
                  onChanged: (value) {
                    if (_textController.text.isEmpty){
                      setState(() => isSearchPressed = false);
                      BlocProvider.of<HouseListBloc>(context)
                          .add(GetAllHouses());
                    }
                    searchInput = value;
                  },
                  onSubmitted: () {
                    getSpecificHouses();
                  },
                  onClearPressed: () {
                    setState(() {
                      isSearchPressed = false;
                      _textController.clear();
                      BlocProvider.of<HouseListBloc>(context)
                          .add(GetAllHouses());
                    });
                  },
                  onSearchPressed: () {
                    getSpecificHouses();
                    setState(() => isSearchPressed = true);
                  },
                  isSearchPressed: isSearchPressed),
            ],
          ),
          kIsWeb ? SizedBox(height: 20) : SizedBox(height: 0),
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
                        CupertinoPageRoute(
                          builder: (context) => HouseDetailWidget(
                            houseModel: house,
                            distance: distances.containsKey(house.id)
                                ? '${distances[house.id]} km'
                                : '2,5km',
                          ),
                        ));
                  },
                  child: HouseListCardWidget(
                    house: house,
                    isFavorite: favoriteHouses.isFavorite(house.id),
                    distance: distances.containsKey(house.id)
                        ? '${distances[house.id]} km'
                        : '2,5km',
                    onTap: (value) {
                      setState(() {
                        if (favoriteHouses.isFavorite(house.id)) {
                          favoriteHouses.removeFavoriteHouse(house.id);
                        } else {
                          favoriteHouses.addFavoriteHouse(house.id);
                        }
                      });
                      BlocProvider.of<HouseListBloc>(context)
                          .add(AddFavorite(houseModel: house));
                    },
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
