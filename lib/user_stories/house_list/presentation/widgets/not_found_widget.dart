import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/assets/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/dtos/house_search_params.dart';
import '../bloc/bloc/house_list_bloc.dart';

class NotFoundWidget extends StatefulWidget {
  const NotFoundWidget({super.key});

  @override
  State<NotFoundWidget> createState() => _NotFoundWidgetState();
}

class _NotFoundWidgetState extends State<NotFoundWidget> {
  late String searchInput;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
                  controller: TextEditingController(),
                  onChanged: (value) {
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
                      icon: SvgPicture.asset(
                        "lib/assets/Icons/ic_search.svg",
                        color: DesignSystemColors.medium,
                      ),
                      onPressed: () => getSpecificHouses(),
                    ),
                  ),
                ),
              ),
            ),
          ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "lib/assets/Images/search_state_empty.png",
                height: 250,
              ),
              SizedBox(height: 40),
              const Text('No results found!',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'GothamSSm',
                    fontWeight: FontWeight.w500,
                    color: DesignSystemColors.light,
                  )),
              const Text(
                'Perhaps try another search?',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'GothamSSm',
                    fontWeight: FontWeight.w500,
                    color: DesignSystemColors.light,
                  )
                ),
            ],
          ),
        ),
      )
    ]);
  }

  void getSpecificHouses() {
    FocusManager.instance.primaryFocus?.unfocus();
    TextEditingController().clear();
    BlocProvider.of<HouseListBloc>(context).add(GetSpecificHouses(
        houseSearchParams: HouseSearchParams(city: searchInput, zip: null)));
  }
}
