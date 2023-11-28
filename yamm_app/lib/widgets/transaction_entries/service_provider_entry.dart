import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class serviceProviderEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const serviceProviderEntry(
      {super.key, required TransactionControllers this.controllers});

  @override
  State<serviceProviderEntry> createState() => _serviceProviderEntryState();
}

class _serviceProviderEntryState extends State<serviceProviderEntry> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Service provider'),
      controller: widget.controllers.serviceProviderCont,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a service provider.';
        }
        return null;
      },
    );
  }
}
