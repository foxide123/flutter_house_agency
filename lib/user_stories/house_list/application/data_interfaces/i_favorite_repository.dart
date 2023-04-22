import 'package:dartz/dartz.dart';

import '../../../../shared/failures.dart';
import '../../domain/models/house_model.dart';

abstract class IFavoriteRepository{
  Future<void> addFavorite(HouseModel houseToAdd);
  Future<Either<Failure, List<HouseModel>>> getAllFavorites();
}