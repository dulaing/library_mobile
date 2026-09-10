abstract class Failure {
  const Failure(this.message); // constructor
  // it takes one argument and assigns it to "message"

  final String message;
}

class DataFailure extends Failure {
  // constructor for DataFailure (takes no arguments)
  const DataFailure()
    : super(
        'Could not load books.',
      ); //super calls the parent Failure constructor
}

class BorrowingFailure extends Failure {
  const BorrowingFailure(String message) : super(message);
}

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

/*
  final failure = DataFailure();

  print(failure.message);

                 prints "Could not load books."
*/
