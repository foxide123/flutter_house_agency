import '../../shared/failures.dart';

class DistanceCalcFailure extends Failure{
  final String message;

  DistanceCalcFailure({this.message = "There was a failure when calculating distance"});


  @override
  List<Object?> get props => [message];
}