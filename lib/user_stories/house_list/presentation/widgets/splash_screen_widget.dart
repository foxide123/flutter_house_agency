import 'package:flutter/material.dart';
import 'package:flutter_assignment_project/user_stories/house_list/presentation/bloc/bloc/house_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenWidget extends StatelessWidget{

  const SplashScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HouseListBloc>(context)
          .add(GetAllHouses());
    });

    return Container(
      color: Colors.red,
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SvgPicture.asset('lib/assets/Icons/ic_dtt.svg'),
        ],
      )
    );
  }

}