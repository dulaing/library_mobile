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

/*
  final failure = DataFailure();

  print(failure.message);

                 prints "Could not load books."
*/
