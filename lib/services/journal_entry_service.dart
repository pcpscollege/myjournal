import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/journal_entry.dart';

class JournalEntryService {
  final CollectionReference journalCollection =
      FirebaseFirestore.instance.collection("journal_entry");

  void saveJournalEntry(JournalEntry entry) {
    //journalCollection.add(entry.toMap());
    journalCollection.doc(entry.entryId).set(entry.toMap());
  }

  void updateJournalEntry(JournalEntry entry) {
    var options = SetOptions(merge: true);
    journalCollection.doc(entry.entryId).set(entry.toMap(), options);
  }

  Future<void> removeJournalEntry(String entryId) {
    return journalCollection.doc(entryId).delete();
  }

  Stream<QuerySnapshot> getJournalStream() {
    return journalCollection.snapshots();
  }

  Stream<QuerySnapshot> getLastestJournalStream() {
    return journalCollection
        .where('date',
            isGreaterThan:
                DateTime.now().add(const Duration(days: -10)).toIso8601String())
        .snapshots();
  }
}
