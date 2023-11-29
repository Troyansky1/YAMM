import 'package:flutter/material.dart';

enum TransactionEnum {
  id(
    showField: false,
    showTitle: false,
    showIcon: false,
    title: "",
    icon: Icon(Icons.adjust),
  ),
  isOutcome(
    showField: false,
    showTitle: false,
    showIcon: false,
    title: "",
    icon: Icon(Icons.adjust),
  ),
  amount(
    showField: true,
    showTitle: false,
    showIcon: true,
    title: "",
    icon: Icon(Icons.monetization_on_rounded),
  ),
  serviceProvider(
    showField: true,
    showTitle: false,
    showIcon: false,
    title: "",
    icon: Icon(Icons.adjust),
  ),
  date(
    showField: true,
    showTitle: false,
    showIcon: true,
    title: "",
    icon: Icon(Icons.date_range),
  );

  const TransactionEnum({
    required this.showField,
    required this.showTitle,
    required this.showIcon,
    required this.title,
    required this.icon,
  });

  final bool showField;
  final bool showTitle;
  final bool showIcon;
  final String title;
  final Icon icon;
}
