import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';

class ShowChosenLabels extends StatefulWidget {
  late TransactionControllers transactionControllers;
  ShowChosenLabels({super.key, required this.transactionControllers});

  @override
  State<ShowChosenLabels> createState() => _ShowChosenLabelsState();
}

class _ShowChosenLabelsState extends State<ShowChosenLabels> {
  void initState() {
    super.initState();

    widget.transactionControllers
        .addListener(() => mounted ? setState(() {}) : null);
  }

  List<Widget> getChosenItems(List<String> lst) {
    List<Widget> chosenItems = List<Widget>.empty(growable: true);

    for (String item in lst) {
      InputChip chip = InputChip(
        label: Text('#$item'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.transparent),
        ),
        labelPadding: const EdgeInsets.all(1),
        onDeleted: () {
          setState(() {
            widget.transactionControllers.labels.value.remove(item);
            widget.transactionControllers.labels.value =
                widget.transactionControllers.labels.value;
          });
        },
      );
      chosenItems.add(chip);
    }
    return chosenItems;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<String>>(
      builder: (BuildContext context, List<String> value, Widget? child) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: Wrap(
              spacing: 0, runSpacing: 0.0, children: getChosenItems(value)),
        );
      },
      valueListenable: widget.transactionControllers.labels,
    );
  }
}
