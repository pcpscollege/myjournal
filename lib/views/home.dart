import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../providers/journal_entry_provider.dart';
import '../views/entry.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var entryProvider = Provider.of<JournalEntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journal'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: entryProvider.journalEntries,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              JournalEntry entry = JournalEntry.fromJSON(data);
              return ListTile(
                trailing: const Icon(Icons.edit),
                title: Text(
                  formatDate(
                      DateTime.parse(entry.date), [MM, ' ', d, ', ', yyyy]),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EntryScreen(entry: entry),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EntryScreen()));
        },
      ),
    );
  }
}
