import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/category_enum.dart';

class CategoryEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const CategoryEntry({super.key, required this.controllers});

  @override
  State<CategoryEntry> createState() => _CategoryEntryState();
}

class _CategoryEntryState extends State<CategoryEntry> {
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<TransactionCategory>> categoryOptionsEntries =
        <DropdownMenuItem<TransactionCategory>>[];
    for (final TransactionCategory category in TransactionCategory.values) {
      String name = category.name;
      categoryOptionsEntries.add(
        DropdownMenuItem<TransactionCategory>(
            value: category, child: Text(name)),
      );
    }

    return DropdownButton2<TransactionCategory>(
      value: widget.controllers.categoryValue,
      isExpanded: false,
      alignment: Alignment.bottomCenter,
      buttonStyleData: const ButtonStyleData(width: 110, height: 25),
      dropdownStyleData: const DropdownStyleData(
        width: 110,
        scrollPadding: EdgeInsets.all(0),
        maxHeight: 250,
        padding: EdgeInsets.only(),
        isOverButton: true,
      ),
      items: categoryOptionsEntries,
      onChanged: (TransactionCategory? value) {
        setState(() {
          widget.controllers.categoryValue = value!;
        });
      },
    );
  }
}
