abstract class Failure {
  const Failure(this.message); // constructor
  // it takes one argument and assigns it to "message"

  final String message;
}

class DataFailure extends Failure {
  const DataFailure([String message = 'Could not load books.']) : super(message);
}

class BorrowingFailure extends Failure {
  const BorrowingFailure(String message) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class MemberFailure extends Failure {
  const MemberFailure(String message) : super(message);
}

/*
  final failure = DataFailure();

  print(failure.message);

                 prints "Could not load books."
*/
