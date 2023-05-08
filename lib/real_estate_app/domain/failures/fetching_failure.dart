import '../../shared/failures.dart';

class FetchingFailure extends Failure {
  final String message;

  FetchingFailure(
      {this.message = "No houses found"});

  @override
  List<Object?> get props => [message];
}