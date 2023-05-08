import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment_project/real_estate_app/bloc/bloc/house_list_bloc.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/error_widget.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/favorite_page/favorite_notifier.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/house_list_page/house_list_page.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/offline_widget.dart';
import 'package:flutter_assignment_project/real_estate_app/presentation/widgets/splash_screen_widget.dart';
import 'assets/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'dependency_injection.dart';
import 'dependency_injection.dart' as di;
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType){
        return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: DesignSystemColors.lightGray),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<FavoriteHouses>(
            create: (context) => FavoriteHouses(),
          ),
          BlocProvider<HouseListBloc>(
          create: (context) => sl<HouseListBloc>(),
        ),
        ],
        child:MainAppContent(),
      ),
    );
      }
    );
  }
}

class MainAppContent extends StatefulWidget {
  @override
  State<MainAppContent> createState() => _MainAppContentState();
}

class _MainAppContentState extends State<MainAppContent> {
  Widget previousState = DisplayError(message: 'Unknown state error');

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, snapshot) {
            return OfflineWidget(isOffline: snapshot.data == ConnectivityResult.none);
          },
        ),
        BlocListener<HouseListBloc, HouseListState>(
          listener: (context, state) {
            if (state is Loaded) {
              BlocProvider.of<HouseListBloc>(context).add(
                  SortHouses(listOfHouses: state.listOfHouses, ascending: true));
            }
          },
          child: BlocBuilder<HouseListBloc, HouseListState>(
            builder: (context, state) {
              if (state is Empty) {
                previousState = SplashScreenWidget();
              } else if (state is Loading) {
                previousState = SplashScreenWidget();
              } else if (state is ListSorted) {
                previousState = HouseListPage(houses: state.listOfHouses);
              } else if (state is Error) {
                previousState = DisplayError(message: state.message);
              } else if (state is NotFound) {
                previousState = HouseListPage();
              } else if (state is DistanceLoaded) {
                
              } else if(state is FavoriteAdded){
   
              } else if(state is FavoriteRemoved){
                
              }else if(state is FavoritesRetrieved){
                
              }
              else if(state is NoInternet){
                //previousState = OfflineWidget(isOffline: true);
              }
              else {
                previousState = DisplayError(message: 'Unknown state error');
              }
              return previousState;
            },
          ),
        ),
      ],
    );
  }
}