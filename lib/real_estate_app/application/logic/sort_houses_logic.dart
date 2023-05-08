import 'package:dartz/dartz.dart';

import '../../shared/failures.dart';
import '../../domain/failures/sorting_failure.dart';
import '../../domain/models/house_model.dart';
import '../logic_interfaces/i_sort_houses_logic.dart';

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