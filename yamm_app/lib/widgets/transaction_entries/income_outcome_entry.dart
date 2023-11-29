import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class IncomeOutcomeEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const IncomeOutcomeEntry({super.key, required this.controllers});

  @override
  State<IncomeOutcomeEntry> createState() => _IncomeOutcomeEntryState();
}

class _IncomeOutcomeEntryState extends State<IncomeOutcomeEntry> {
  final List<bool> _incomeOutcome = [true, false];
  void setIncomeOutcome(int indexToToggle) {
    // Presses the current button and unpresses the other button. Does nothing if button is pressed.
    int index = indexToToggle;
    setState(() {
      if (!_incomeOutcome[index]) {
        _incomeOutcome[index] = !_incomeOutcome[index];
        _incomeOutcome[(index + 1) % 2] = !_incomeOutcome[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      constraints: BoxConstraints(
          minWidth: (MediaQuery.of(context).size.width - 36) / 3),
      onPressed: (int index) => setIncomeOutcome(index),
      isSelected: _incomeOutcome,
      borderRadius: BorderRadius.circular(40),
      borderWidth: 5,
      children: const [Text("Income"), Text("Outcome")],
    );
  }
}
