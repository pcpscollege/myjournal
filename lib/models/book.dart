class Book {
  final String bookId;
  final String bookName;
  final String? author;

  Book({required this.bookId, required this.bookName, this.author});

  factory Book.fromJSON(Map<String, dynamic> json) {
    return Book(
      bookId: json['bookId'],
      bookName: json['bookName'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'bookName': bookName,
      'author': author,
    };
  }
}
