import '../../shared/failures.dart';

class RemoveFavoriteFailure extends Failure {
  final String message;

  RemoveFavoriteFailure(
      {this.message = "There was a failure when removing favorite"});

  @override
  List<Object?> get props => [message];
}