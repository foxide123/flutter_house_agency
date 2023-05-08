import '../../shared/failures.dart';

class SortingFailure extends Failure{
  final String message;

  SortingFailure({this.message = "There was a failure when loading houses by price."});


  @override
  List<Object?> get props => [message];
}