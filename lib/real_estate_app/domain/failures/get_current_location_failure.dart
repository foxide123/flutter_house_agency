import '../../shared/failures.dart';

class GetCurrentLocationFailure extends Failure {
  final String message;

  GetCurrentLocationFailure(
      {this.message = "There was a failure when requesting permission"});

  @override
  List<Object?> get props => [message];
}