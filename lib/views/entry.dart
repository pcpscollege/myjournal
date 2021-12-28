import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/journal_entry.dart';
import '../providers/journal_entry_provider.dart';

class EntryScreen extends StatefulWidget {
  // If we are passing existing entry then
  final JournalEntry? entry;

  EntryScreen({Key? key, this.entry}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  ////////// Write only after the provider /////////////
  final entryController = TextEditingController();

  void dispose() {
    entryController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final entryProvider =
        Provider.of<JournalEntryProvider>(context, listen: false);
    if (widget.entry != null) {
      // Edit
      entryController.text = widget.entry!.entry;
      entryProvider.loadAll(widget.entry);
    } else {
      entryProvider.loadAll(null);
    }
    super.initState();
  }

  /////////////////////////
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<JournalEntryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(formatDate(entryProvider.date, [MM, ' ', d, ',', yyyy])),
        // display after creating the entry.dart file
        actions: [
          IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {
                _pickDate(context).then((value) {
                  if (value != null) {
                    entryProvider.changeDate = value;
                  }
                });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Daily Entry',
                border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) {
                entryProvider.changeEntry = value;
              },
              controller: entryController,
            ),
            ElevatedButton(
              onPressed: () {
                entryProvider.saveEntry();
                Navigator.of(context).pop();
              },
              child: (widget.entry != null)
                  ? const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
            ),
            // add conditional argument for delete button
            (widget.entry != null)
                ? ElevatedButton(
                    onPressed: () {
                      entryProvider.removeEntry(widget.entry!.entryId);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2040));
    if (picked != null) return picked;
  }
}
