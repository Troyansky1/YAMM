import 'package:flutter/material.dart';
import 'package:yamm_app/currency_enum.dart';

enum TransactionEnum {
  id(
    showField: false,
    showTitle: false,
    showIcon: false,
    title: "id",
    icon: Icon(Icons.adjust),
    type: int,
    position: 0,
  ),
  isOutcome(
    showField: false,
    showTitle: false,
    showIcon: false,
    title: "Outcome",
    icon: Icon(Icons.adjust),
    type: bool,
    position: 1,
  ),
  amount(
    showField: true,
    showTitle: false,
    showIcon: true,
    title: "Amount",
    icon: Icon(Icons.monetization_on_rounded),
    type: int,
    position: 2,
  ),
  serviceProvider(
    showField: true,
    showTitle: false,
    showIcon: false,
    title: "Service provider",
    icon: Icon(Icons.adjust),
    type: String,
    position: 3,
  ),
  date(
    showField: true,
    showTitle: false,
    showIcon: true,
    title: "date",
    icon: Icon(Icons.date_range),
    type: DateTime,
    position: 4,
  ),
  currency(
    showField: true,
    showTitle: false,
    showIcon: false,
    title: "Currency",
    icon: Icon(Icons.adjust),
    type: Currency,
    position: 5,
  );

  const TransactionEnum({
    required this.showField,
    required this.showTitle,
    required this.showIcon,
    required this.title,
    required this.icon,
    required this.type,
    required this.position,
  });

  final bool showField;
  final bool showTitle;
  final bool showIcon;
  final String title;
  final Icon icon;
  final Type type;
  final int position;

  String getTitleFromPosition(int position) {
    String title = "";
    for (TransactionEnum field in TransactionEnum.values) {
      if (position == field.position) {
        title = field.title;
      }
    }
    return title;
  }

  Type getTypeFromPosition(int position) {
    Type type = Type;
    for (TransactionEnum field in TransactionEnum.values) {
      if (position == field.position) {
        type = field.type;
      }
    }
    return type;
  }
}
