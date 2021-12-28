class JournalEntry {
  final String entryId;
  final String date;
  final String entry;

  JournalEntry(
      {required this.entryId, required this.date, required this.entry});

  factory JournalEntry.fromJSON(Map<String, dynamic> json) {
    return JournalEntry(
      entryId: json['entryId'],
      date: json['date'],
      entry: json['entry'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'entry': entry,
      'entryId': entryId,
    };
  }
}
