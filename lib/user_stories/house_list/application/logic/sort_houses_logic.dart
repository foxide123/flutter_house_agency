import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/logic_interfaces/i_sort_houses_logic.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';

class SortHousesLogic implements ISortHousesLogic{
  @override
  Future<Either<Failure, List<HouseModel>>> sortByPrice(List<HouseModel> houseList, {bool ascending=true}) async{
    try{
      List<HouseModel> listToSort = houseList;
      if(ascending){
        listToSort.sort((a,b) => a.price.compareTo(b.price));
      }else{
        listToSort.sort((a,b) => b.price.compareTo(a.price));
      }
      return Right(listToSort);
    }on Exception{
      return Left(SortingFailure());
    }
  }
}

class SortingFailure extends Failure{
  final String message;

  SortingFailure({this.message = "There was a failure when loading houses by price."});


  @override
  List<Object?> get props => [message];
}