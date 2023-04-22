import 'package:flutter/material.dart';
import 'package:flutter_assignment_project/assets/colors.dart';
import 'package:flutter_assignment_project/user_stories/house_list/domain/dtos/house_search_params.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/favorite_page/favorite_widget.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/not_found_widget.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/house_model.dart';
import '../../bloc/bloc/house_list_bloc.dart';
import '../info_page/info_widget.dart';

class HouseListPage extends StatefulWidget {
  final List<HouseModel>? houses;

  const HouseListPage({this.houses});

  @override
  State<HouseListPage> createState() => _HouseListPageState();
}

class _HouseListPageState extends State<HouseListPage> {
  Map<int, double> distances = {};
  late String searchInput;
  int currentIndex = 0;

  void _updateDistance(int houseId, double distance) {
    setState(() {
      distances[houseId] = distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if (state is DistanceLoaded) {
          _updateDistance(state.houseId, state.distance);
        }
      },
    );

    final List<Widget> pages = [
      widget.houses == null
          ? NotFoundWidget()
          : HouseListWidget(houses: widget.houses!),
      InfoWidget(),
      FavoriteWidget(),
    ];

    return Expanded(
      child: Scaffold(
        body: SingleChildScrollView(
          child: pages[currentIndex],
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: DesignSystemColors.light,
                  blurRadius: 10,
                ),
              ],
            ),
            child: BottomNavigationBar(
              /*labels are mandatory but we don't need them
      so they are hidden*/
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: DesignSystemColors.strong,
              unselectedItemColor: DesignSystemColors.white,
              backgroundColor: DesignSystemColors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "lib/assets/Icons/ic_home.svg",
                    color: currentIndex == 0
                        ? DesignSystemColors.strong
                        : DesignSystemColors.light,
                    width: 26,
                    height: 26,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    child: SvgPicture.asset(
                      "lib/assets/Icons/ic_info.svg",
                      width: 26,
                      height: 26,
                      color: currentIndex == 1
                          ? DesignSystemColors.strong
                          : DesignSystemColors.light,
                    ),
                    onTap: () => setState(() => currentIndex = 1),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: GestureDetector(
                    child: Icon(
                      Icons.favorite,
                      color: currentIndex == 2
                          ? DesignSystemColors.strong
                          : DesignSystemColors.light,
                    ),
                    onTap: () => setState(() => currentIndex = 2),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getSpecificHouses() {
    FocusManager.instance.primaryFocus?.unfocus();
    TextEditingController().clear();
    BlocProvider.of<HouseListBloc>(context).add(GetSpecificHouses(
        houseSearchParams: HouseSearchParams(city: searchInput, zip: null)));
  }
}
