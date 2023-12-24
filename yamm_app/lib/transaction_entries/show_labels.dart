import 'package:flutter/material.dart';

class ShowChosenLabels extends StatefulWidget {
  late List<String> outputList;
  ShowChosenLabels({super.key, required this.outputList});

  @override
  State<ShowChosenLabels> createState() => _ShowChosenLabelsState();
}

class _ShowChosenLabelsState extends State<ShowChosenLabels> {
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
            widget.outputList.remove(item);
            widget.outputList = widget.outputList;
          });
        },
      );
      chosenItems.add(chip);
    }
    return chosenItems;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 500,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Wrap(
                spacing: 1,
                runSpacing: 0.0,
                children: getChosenItems(widget.outputList)),
          ),
        ],
      ),
    );
  }
}
