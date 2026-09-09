import '../../domain/entities/borrowing.dart';

class BorrowingModel extends Borrowing {
  BorrowingModel({
    required super.id,
    required super.memberId,
    required super.bookId,
    required super.borrowedDate,
    required super.dueDate,
    required super.returnedDate,
    required super.status,
  });

  factory BorrowingModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final returnedDateText = json['returnedDate'] as String?;

    return BorrowingModel(
      id: json['id'] as int,
      memberId: json['memberId'] as int,
      bookId: json['bookId'] as int,
      borrowedDate: DateTime.parse(
        json['borrowedDate'] as String,
      ),
      dueDate: DateTime.parse(
        json['dueDate'] as String,
      ),
      returnedDate: returnedDateText == null
          ? null
          : DateTime.parse(returnedDateText),
      status: json['status'] as String,
    );
  }
}