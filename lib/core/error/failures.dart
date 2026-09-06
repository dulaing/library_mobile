abstract class Failure {
  const Failure(this.message);

  final String message;
}

class DataFailure extends Failure {
  const DataFailure() : super('Could not load books.');
}