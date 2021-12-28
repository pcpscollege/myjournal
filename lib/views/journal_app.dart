import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_entry_provider.dart';
import '../views/home.dart';

class JournalApp extends StatefulWidget {
  @override
  _JournalAppState createState() => _JournalAppState();
}

class _JournalAppState extends State<JournalApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JournalEntryProvider>(
            create: (_) => JournalEntryProvider()),
      ],
      child: MaterialApp(
        home: HomeScreen(),
        theme: ThemeData(
          primaryColor: Colors.black,
        ),
      ),
    );
  }
}
