import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/assets/colors.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/models/house_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../bloc/bloc/house_list_bloc.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  
  List<HouseModel> favorites = [];

  @override
  void initState() {
    super.initState();
      BlocProvider.of<HouseListBloc>(context).add(GetFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if (state is FavoritesRetrieved) {
          setState(() {
            print(state.houses[0].bathrooms);
            favorites = state.houses;
          });
      }
      },
      child: Column(
        children: [
          ListView.builder(
           physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final house = favorites[index];
               return Center(
                    child: SizedBox(
                      height: 150,
                      width: 700,
                      child: Card(
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
                                          Text( '2,5km',
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
                  );
            }

          ),
        ],
      ),
    );
  }
}
