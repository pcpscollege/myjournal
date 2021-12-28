import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class BookService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("book");

  void save(Book obj) {
    //journalCollection.add(entry.toMap());
    collection.doc(obj.bookId).set(obj.toMap());
  }

  void update(Book obj) {
    var options = SetOptions(merge: true);
    collection.doc(obj.bookId).set(obj.toMap(), options);
  }

  Future<void> remove(String id) {
    return collection.doc(id).delete();
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getLastestStream() {
    return collection
        .where('date',
            isGreaterThan:
                DateTime.now().add(const Duration(days: -10)).toIso8601String())
        .snapshots();
  }
}
