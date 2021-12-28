import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/journal_entry.dart';
import '../services/journal_entry_service.dart';

class JournalEntryProvider with ChangeNotifier {
  final journalEntryService = JournalEntryService();

  late String _entryId;
  late DateTime _date;
  late String _entry;
  var uuid = Uuid();

  // Getters
  DateTime get date => _date;
  String get entry => _entry;
  Stream<QuerySnapshot> get journalEntries =>
      journalEntryService.getJournalStream();

  // Setters
  set changeDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  set changeEntry(String entry) {
    _entry = entry;
    notifyListeners();
  }

  loadAll(JournalEntry? entry) {
    if (entry != null) {
      _date = DateTime.parse(entry.date);
      _entry = entry.entry;
      _entryId = entry.entryId;
    } else {
      _date = DateTime.now();
      entry = null;
      _entryId = '';
    }
  }

  saveEntry() {
    if (_entryId == "") {
      var newEntry = JournalEntry(
          date: _date.toIso8601String(), entry: _entry, entryId: uuid.v1());
      journalEntryService.saveJournalEntry(newEntry);
    } else {
      var updateEntry = JournalEntry(
          date: _date.toIso8601String(), entry: _entry, entryId: _entryId);
      journalEntryService.updateJournalEntry(updateEntry);
    }
  }

  removeEntry(String entryId) {
    journalEntryService.removeJournalEntry(entryId);
  }
}
