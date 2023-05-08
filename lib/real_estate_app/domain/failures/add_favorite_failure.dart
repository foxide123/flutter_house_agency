import '../../shared/failures.dart';

class AddFavoriteFailure extends Failure {
  final String message;

  AddFavoriteFailure(
      {this.message = "There was a failure when adding favorite"});

  @override
  List<Object?> get props => [message];
}