import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:yamm_app/transaction_controllers.dart';

class ServiceProviderEntry extends StatefulWidget {
  //final Widget child;

  final TransactionControllers controllers;
  const ServiceProviderEntry({super.key, required this.controllers});

  @override
  State<ServiceProviderEntry> createState() => _ServiceProviderEntryState();
}

class _ServiceProviderEntryState extends State<ServiceProviderEntry> {
  bool isValidStr(String? str) {
    if (str == null || str.isEmpty) {
      return false;
    } else {
      String strippedStr = blacklist(str, ' ,.');
      if (isAlpha(strippedStr)) {
        return true;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: ' Title',
        labelStyle: Theme.of(context).textTheme.titleMedium,
        contentPadding: EdgeInsets.symmetric(vertical: 1.0),
      ),
      controller: widget.controllers.serviceProviderCont,
      autovalidateMode: AutovalidateMode.disabled,
    );
  }
}
