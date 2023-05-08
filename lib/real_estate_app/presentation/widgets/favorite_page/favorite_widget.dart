import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../../../assets/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../bloc/bloc/house_list_bloc.dart';
import '../../../domain/models/house_model.dart';
import '../house_detail_page/house_detail_widget.dart';
import '../offline_widget.dart';
import 'favorite_card_widget.dart';
import 'favorite_notifier.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  Map<int, String> distances = {};
  List<HouseModel>? favorites = [];
  bool isOnline = true;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<HouseListBloc>(context).add(GetFavorites());
  }

  @override
  Widget build(BuildContext context) {
    final favoriteHouses = Provider.of<FavoriteHouses>(context);
    return BlocListener<HouseListBloc, HouseListState>(
        listener: (context, state) {
          if (state is FavoritesRetrieved) {
            if (state.houses.isNotEmpty) {
              BlocProvider.of<HouseListBloc>(context)
                  .add(GetDistancesToHouses(houses: state.houses));
              setState(() {
                favorites = state.houses;
                _opacity = 1;
              });
            }
          }
          if (state is NoInternet) {
            setState(() {
              isOnline = !isOnline;
            });
          }
          if (state is DistanceLoaded) {
            setState(() {
              distances = state.distances;
            });
          }
        },
        child: isOnline
            ? AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _opacity,
                child: favorites == null
                    ? Text('Add favorite')
                    : Column(
                        children: [
                          SizedBox(height: 20),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: favorites!.length,
                              itemBuilder: (context, index) {
                                final house = favorites![index];
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                HouseDetailWidget(
                                              houseModel: house,
                                              distance: distances
                                                      .containsKey(house.id)
                                                  ? '${distances[house.id]} km'
                                                  : '2,5km',
                                            ),
                                          ));
                                    },
                                    child: FavoriteCardWidget(
                                        house: house,
                                        distance:
                                            distances.containsKey(house.id)
                                                ? '${distances[house.id]} km'
                                                : '2,5km',
                                        onClosePressed: (value) => {
                                              setState(() {
                                                favorites!.remove(value);
                                                favoriteHouses
                                                    .removeFavoriteHouse(
                                                        value.id);
                                              }),
                                              BlocProvider.of<HouseListBloc>(
                                                      context)
                                                  .add(RemoveFavorite(
                                                      houseModel: value)),
                                            }));
                              }),
                        ],
                      ),
              )
            : OfflineWidget(isOffline: true));
  }
}
