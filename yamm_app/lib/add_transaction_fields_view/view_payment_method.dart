import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class PaymentMethodChoice extends StatefulWidget {
  late TransactionControllers transactionControllers;
  PaymentMethodChoice({super.key, required this.transactionControllers});

  @override
  State<PaymentMethodChoice> createState() => _PaymentMethodChoiceState();
}

class _PaymentMethodChoiceState extends State<PaymentMethodChoice> {
  void initState() {
    super.initState();

    widget.transactionControllers
        .addListener(() => mounted ? setState(() {}) : null);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      builder: (BuildContext context, List<String> value, Widget? child) {
        String paymentMethod = "";
        if (value.isNotEmpty) {
          paymentMethod = value.first;
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Wrap(
              spacing: 0,
              runSpacing: 0.0,
              children: <Widget>[Text(paymentMethod)]),
        );
      },
      valueListenable: widget.transactionControllers.paymentMethods,
    );
  }
}
