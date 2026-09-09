class Borrowing {
  final int id;
  final int memberId;
  final int bookId;
  final DateTime borrowedDate;
  final DateTime dueDate;
  final DateTime? returnedDate;
  final String status;

  Borrowing({
    required this.id,
    required this.memberId,
    required this.bookId,
    required this.borrowedDate,
    required this.dueDate,
    required this.returnedDate,
    required this.status,
  });
}