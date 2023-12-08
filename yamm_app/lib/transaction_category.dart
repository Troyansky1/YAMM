import 'package:flutter/material.dart';
import 'dart:convert';

class TransactionCategory {
  final String name;
  final Icon icon;
  final bool income;
  final bool outcome;

  TransactionCategory(this.name, this.icon, this.income, this.outcome);
}
