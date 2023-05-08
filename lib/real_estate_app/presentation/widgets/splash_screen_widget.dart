import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../bloc/bloc/house_list_bloc.dart';
import 'offline_widget.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({
    super.key,
  });

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  bool isOnline = true;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HouseListBloc>(context).add(GetAllHouses());
    });
    return BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if(state is NoInternet){
          setState((){
            isOnline = !isOnline;
          });
        }
      },
      child: isOnline? Container(
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
          )) : OfflineWidget(isOffline: true),
    );
  }
}
