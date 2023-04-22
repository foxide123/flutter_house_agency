import 'package:dartz/dartz.dart';
import 'package:flutter_assignment_project/user_stories/house_list/application/data_interfaces/i_favorite_repository.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';
import '../data_interfaces/i_houses_repository.dart';

class FavoriteHousesLogic implements IFavoriteRepository{
  final IFavoriteRepository repository;

  FavoriteHousesLogic(this.repository);

  Future<Either<Failure, void>> addFavorite(HouseModel houseModel) async{
    try{
      await repository.addFavorite(houseModel);
      return Right('');
    }catch(error){
      return Left(FetchingFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<HouseModel>>> getAllFavorites() async{
    final favorites = await repository.getAllFavorites();

    return favorites.fold(
      (failure){
        return Left(FetchingFailure());
      },
      (fav){
        return Right(fav);
      });
  }
}

class FetchingFailure extends Failure {
  final String message;

  FetchingFailure(
      {this.message = "There was a failure when geting specific houses"});

  @override
  List<Object?> get props => [message];
}