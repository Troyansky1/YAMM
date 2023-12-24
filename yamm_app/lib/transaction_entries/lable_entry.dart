import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/functions/preferences.dart';
import 'package:yamm_app/transaction_entries/chip_input.dart';
import 'package:yamm_app/transaction_entries/chip_input_editin_controller.dart';
import 'dart:async';
import 'package:yamm_app/user_preferences.dart';

class LableEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const LableEntry({super.key, required this.controllers});

  @override
  State<LableEntry> createState() => _LableEntryState();
}

class _LableEntryState extends State<LableEntry> {
  final FocusNode _chipFocusNode = FocusNode();

  late FutureOr<List<String>> _labels;
  List<String> _suggestions = <String>[];

  @override
  void initState() {
    super.initState();
    _labels = getPreferencesList('labels');
  }

  _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChipsInput<String>(
                        values: widget.controllers.labels,
                        strutStyle: const StrutStyle(fontSize: 15),
                        onChanged: (List<String> data) {
                          _onChanged(data, setModalState);
                        },
                        onSubmitted: (String data) {
                          _onSubmitted(data, setModalState);
                        },
                        chipBuilder: (BuildContext context, String str) {
                          return _chipBuilder(context, str, setModalState);
                        },
                        onTextChanged: (String data) {
                          _onSearchChanged(data, setModalState);
                        },
                      ),
                    ),
                    if (_suggestions.isNotEmpty)
                      SizedBox(
                        height: 200,
                        child: Wrap(
                            spacing: 1,
                            runSpacing: 0.0,
                            children:
                                getSuggstions(_suggestions, setModalState)),
                      ),
                  ],
                ),
              ),
            );
          });
        });
    return widget.controllers.labels;
  }

  List<Widget> getSuggstions(List<String> lst, StateSetter setModalState) {
    List<ActionChip> suggestions = List<ActionChip>.empty(growable: true);
    for (String lable in lst) {
      ActionChip chip = ActionChip(
        label: Text(lable),
        onPressed: () {
          _selectSuggestion(lable, setModalState);
        },
      );
      suggestions.add(chip);
    }
    return suggestions;
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
                children: getChosenLabels(widget.controllers.labels)),
          ),
        ],
      ),
    );
  }

  List<Widget> getChosenLabels(List<String> lst) {
    List<Widget> chosenLabels = List<Widget>.empty(growable: true);

    for (String lable in lst) {
      InputChip chip = InputChip(
        label: Text('#$lable'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: Colors.transparent),
        ),
        labelPadding: EdgeInsets.all(1),
        onDeleted: () {
          _onChipDeleted(lable, setState);
        },
        onSelected: (bool True) {
          _onChipTapped(lable, setState);
        },
      );
      chosenLabels.add(chip);
    }
    chosenLabels.add(ElevatedButton(
      onPressed: () async {
        List<String> labels = await _labels;
        _suggestions =
            getSuggestionsWithoutChosen(labels, widget.controllers.labels);

        await _showModalSheet();
      },
      child: const Text("Add labels"),
    ));
    return chosenLabels;
  }

  Future<void> _onSearchChanged(String value, StateSetter setModalState) async {
    final List<String> results = await _suggestionCallback(value);
    setModalState(() {
      _suggestions =
          getSuggestionsWithoutChosen(results, widget.controllers.labels);
    });
  }

  Widget _chipBuilder(
      BuildContext context, String lable, StateSetter setModalState) {
    return ToppingInputChip(
      item: lable,
      onDeleted: (String str) {
        _onChipDeleted(str, setModalState);
      },
      onSelected: (String str) {
        _onChipTapped(str, setModalState);
      },
    );
  }

  void _selectSuggestion(String lable, StateSetter setModalState) async {
    List<String> labels = await _labels;
    if (widget.controllers.labels.length < defaultMaxLabels) {
      setModalState(() {
        widget.controllers.labels.add(lable);
        _suggestions =
            getSuggestionsWithoutChosen(labels, widget.controllers.labels);
      });
      setState(() {
        widget.controllers.labels = widget.controllers.labels;
      });
    }
  }

  void _onChipTapped(String lable, StateSetter setModalState) async {}

  void _onChipDeleted(String lable, StateSetter setModalState) async {
    List<String> labels = await _labels;
    setModalState(() {
      widget.controllers.labels.remove(lable);
      _suggestions =
          getSuggestionsWithoutChosen(labels, widget.controllers.labels);
    });
    setState(() {
      widget.controllers.labels = widget.controllers.labels;
    });
  }

  void _onSubmitted(String text, StateSetter setModalState) async {
    List<String> labels = await _labels;
    if (widget.controllers.labels.length < defaultMaxLabels) {
      if (text.trim().isNotEmpty) {
        setModalState(() {
          widget.controllers.labels = <String>[
            ...widget.controllers.labels,
            text.trim()
          ];
        });
      }
      setModalState(() {
        _suggestions =
            getSuggestionsWithoutChosen(labels, widget.controllers.labels);
      });
      setState(() {
        widget.controllers.labels = widget.controllers.labels;
      });
    } else {}
  }

  void _onChanged(List<String> data, StateSetter setModalState) {
    setModalState(() {
      widget.controllers.labels = data;
      _chipFocusNode.unfocus();
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) async {
    List<String> labels = await _labels;
    if (text.isNotEmpty || text.trim() != "") {
      return labels.where((String lable) {
        return lable.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return labels;
  }

  List<String> getSuggestionsWithoutChosen(
      List<String> allLabels, List<String> chosenLabels) {
    return allLabels
        .where((String lable) => !chosenLabels.contains(lable))
        .toList();
  }
}
