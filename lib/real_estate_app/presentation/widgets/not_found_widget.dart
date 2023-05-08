import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/search_widget.dart';
import '../../../assets/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import '../../bloc/bloc/house_list_bloc.dart';
import '../../domain/dtos/house_search_params.dart';

class NotFoundWidget extends StatefulWidget {
  const NotFoundWidget({super.key});

  @override
  State<NotFoundWidget> createState() => _NotFoundWidgetState();
}

class _NotFoundWidgetState extends State<NotFoundWidget> {
  late String searchInput;
  final _textController = TextEditingController();
  bool isSearchPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SafeArea(
                child: Padding(
                  padding: kIsWeb
                      ? EdgeInsets.fromLTRB(0, 40, 150, 0)
                      : EdgeInsets.fromLTRB(0, 25, 0, 0),
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
              Center(
                child: SearchWidget(
                    controller: _textController,
                    onChanged: (value) {
                      if (_textController.text.isEmpty)
                        setState(() => isSearchPressed = false);
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
              ),
            ],
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
                  const Text('Perhaps try another search?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'GothamSSm',
                        fontWeight: FontWeight.w500,
                        color: DesignSystemColors.light,
                      )),
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
