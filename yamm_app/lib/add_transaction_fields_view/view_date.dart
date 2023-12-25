import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class ViewDate extends StatefulWidget {
  final TransactionControllers controllers;
  const ViewDate({super.key, required this.controllers});

  @override
  State<ViewDate> createState() => _ViewDateState();
}

class _ViewDateState extends State<ViewDate> {
  void initState() {
    super.initState();

    widget.controllers.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    String date = widget.controllers.dateCont.text;
    return ValueListenableBuilder<TextEditingValue>(
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return Text(date);
      },
      valueListenable: widget.controllers.dateCont,
    );
  }
}
