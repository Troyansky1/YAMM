import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class NotesEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const NotesEntry({super.key, required this.controllers});

  @override
  State<NotesEntry> createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  bool isValidStr(String? str) {
    if (str == null || str.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 2,
      decoration: InputDecoration(
        labelText: ' Notes',
        labelStyle: Theme.of(context).textTheme.titleMedium,
        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
      ),
      controller: widget.controllers.notesCont,
    );
  }
}
