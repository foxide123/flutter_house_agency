import 'package:dartz/dartz.dart';

import '../../domain/failures/add_favorite_failure.dart';
import '../../domain/failures/remove_favorite_failure.dart';
import '../../domain/models/house_model.dart';
import '../../shared/failures.dart';
import '../data_interfaces/i_favorite_repository.dart';

class FavoriteHousesLogic implements IFavoriteRepository{
  final IFavoriteRepository repository;

  FavoriteHousesLogic(this.repository);

  Future<Either<Failure, HouseModel>> addFavorite(HouseModel houseModel) async{
    try{
      await repository.addFavorite(houseModel);
      return Right(houseModel);
    }catch(error){
      return Left(AddFavoriteFailure());
    }
  }

  Future<Either<Failure, HouseModel>> removeFavorite(HouseModel houseModel) async{
    try{
      await repository.removeFavorite(houseModel);
      return Right(houseModel);
    }catch(error){
      return Left(RemoveFavoriteFailure());
    }
  }
  
  @override
  Future<Either<Failure, List<HouseModel>>> getAllFavorites() async{
    final favorites = await repository.getAllFavorites();

    return favorites.fold(
      (failure){
        return Left(AddFavoriteFailure());
      },
      (fav){
        return Right(fav);
      });
  }
}
