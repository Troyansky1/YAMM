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
  bool isValidStr(String str) {
    String strippedStr = blacklist(str, ' ,.');
    if (isAlpha(strippedStr)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Service provider'),
      controller: widget.controllers.serviceProviderCont,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a service provider.';
        } else if (!isValidStr(value)) {
          return 'Please use letters of the alphabet only.';
        }
        return null;
      },
    );
  }
}
