import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/enum_types/enum_types.dart';
import 'package:yamm_app/user_preferences.dart';

class CategoryEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const CategoryEntry({super.key, required this.controllers});

  @override
  State<CategoryEntry> createState() => _CategoryEntryState();
}

class _CategoryEntryState extends State<CategoryEntry> {
  void initState() {
    super.initState();

    widget.controllers.addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TransactionType>(
        valueListenable: widget.controllers.transactionType,
        builder: (BuildContext context, TransactionType type, Widget? child) {
          final List<DropdownMenuItem<TransactionCategory>>
              categoryOptionsEntries =
              <DropdownMenuItem<TransactionCategory>>[];
          for (final TransactionCategory category
              in TransactionCategory.values) {
            if (category.transactionTypes.contains(type)) {
              String name = category.name;
              categoryOptionsEntries.add(
                DropdownMenuItem<TransactionCategory>(
                    value: category, child: Text(name)),
              );
            }
          }

          if (!widget.controllers.categoryValue.transactionTypes
              .contains(type)) {
            widget.controllers.categoryValue = defaultCategory;
          }

          return DropdownButton2<TransactionCategory>(
            value: widget.controllers.categoryValue,
            isExpanded: false,
            style: GoogleFonts.dosis(
              fontSize: 17,
              color: Colors.black,
            ),
            alignment: Alignment.bottomLeft,
            buttonStyleData: const ButtonStyleData(
                width: 110, height: 40, padding: EdgeInsets.only(left: 5)),
            dropdownStyleData: const DropdownStyleData(
              width: 110,
              scrollPadding: EdgeInsets.all(0),
              maxHeight: 250,
              padding: EdgeInsets.only(left: 5),
              isOverButton: true,
            ),
            items: categoryOptionsEntries,
            onChanged: (TransactionCategory? value) {
              setState(() {
                widget.controllers.categoryValue = value!;
              });
            },
          );
        });
  }
}
