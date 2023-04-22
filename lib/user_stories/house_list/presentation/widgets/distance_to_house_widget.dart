import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/house_model.dart';
import '../bloc/bloc/house_list_bloc.dart';

class DistanceToHouseWidget extends StatefulWidget {
  final HouseModel house;
  final Function(int, double) onDistanceUpdated;

  const DistanceToHouseWidget({required this.house, required this.onDistanceUpdated});

  @override
  State<DistanceToHouseWidget> createState() => _DistanceToHouseWidgetState();
}

class _DistanceToHouseWidgetState extends State<DistanceToHouseWidget> {
  double? _distance;

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<HouseListBloc>(context);
    bloc.add(GetDistanceToHouse(
        lat: widget.house.latitude.toDouble(),
        lon: widget.house.longitude.toDouble(),
        houseId: widget.house.id,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HouseListBloc, HouseListState>(
      listener: (context, state) {
        if (state is DistanceLoaded) {
          widget.onDistanceUpdated(widget.house.id, state.distance);
        }
      },
      child: _distance == null
          ? CircularProgressIndicator()
          : Text(
              _distance.toString(),
            ),
    );
  }
}