import 'package:flutter/material.dart';
import 'package:yamm_app/functions/preferences.dart';
import 'package:yamm_app/transaction_entries/chip_input.dart';
import 'package:yamm_app/transaction_entries/chip_input_editin_controller.dart';
import 'dart:async';
import 'package:yamm_app/user_preferences.dart';

class BottomSheetChipSelect extends StatefulWidget {
  //final Widget child;
  late ValueNotifier<List<String>> chosenItemsList;
  late Function updatevalue;
  late bool replaceWhenEnterNew;
  final String optionsListName;
  final Widget button;
  final int maxSelect;
  BottomSheetChipSelect(
      {super.key,
      required this.chosenItemsList,
      required this.updatevalue,
      required this.replaceWhenEnterNew,
      required this.optionsListName,
      required this.button,
      required this.maxSelect});

  @override
  State<BottomSheetChipSelect> createState() => _BottomSheetChipSelectState();
}

class _BottomSheetChipSelectState extends State<BottomSheetChipSelect> {
  final FocusNode _chipFocusNode = FocusNode();

  late FutureOr<List<String>> _optionslist;
  List<String> _suggestions = <String>[];

  @override
  void initState() {
    super.initState();
    _optionslist = getPreferencesList(widget.optionsListName);
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
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    if (!widget.replaceWhenEnterNew)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ChipsInput<String>(
                          values: widget.chosenItemsList.value,
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
                        width: MediaQuery.of(context).size.width - 40,
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Wrap(
                            spacing: 1,
                            runSpacing: 0.0,
                            children: getSuggstions(_suggestions, setModalState,
                                widget.replaceWhenEnterNew)),
                      ),
                  ],
                ),
              ),
            );
          });
        });
    return widget.chosenItemsList;
  }

  List<Widget> getSuggstions(
      List<String> lst, StateSetter setModalState, bool oneChoice) {
    if (oneChoice) {
      List<ChoiceChip> suggestions = List<ChoiceChip>.empty(growable: true);

      return List<Widget>.generate(
        lst.length,
        (int index) {
          return ChoiceChip(
            label: Text(lst[index]),
            selected: widget.chosenItemsList.value[0] == lst[index],
            onSelected: (bool selected) {
              widget.chosenItemsList.value[0] = lst[index];
              widget.updatevalue();
              setModalState(() {
                widget.chosenItemsList.value = [lst[index]];
              });
            },
          );
        },
      ).toList();
    } else {
      List<ActionChip> suggestions = List<ActionChip>.empty(growable: true);
      for (String item in lst) {
        ActionChip chip = ActionChip(
          label: Text(item),
          onPressed: () {
            _selectSuggestion(item, setModalState);
          },
        );
        suggestions.add(chip);
      }
      return suggestions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return addItemButton(widget.button);
  }

  Widget addItemButton(Widget button) {
    return TextButton(
      onPressed: () async {
        List<String> items = await _optionslist;
        _suggestions =
            getSuggestionsWithoutChosen(items, widget.chosenItemsList.value);

        _showModalSheet();
      },
      child: button,
    );
  }

  Future<void> _onSearchChanged(String value, StateSetter setModalState) async {
    final List<String> results = await _suggestionCallback(value);
    setModalState(() {
      _suggestions =
          getSuggestionsWithoutChosen(results, widget.chosenItemsList.value);
    });
  }

  Widget _chipBuilder(
      BuildContext context, String item, StateSetter setModalState) {
    return ToppingInputChip(
      item: item,
      onDeleted: (String str) {
        _onChipDeleted(str, setModalState);
      },
      onSelected: (String str) {
        _onChipTapped(str, setModalState);
      },
    );
  }

  void _selectSuggestion(String item, StateSetter setModalState) async {
    List<String> items = await _optionslist;
    if (widget.chosenItemsList.value.length < widget.maxSelect) {
      setModalState(() {
        widget.chosenItemsList.value.add(item);
        _suggestions =
            getSuggestionsWithoutChosen(items, widget.chosenItemsList.value);
      });
      widget.updatevalue();
    }
  }

  void _onChipTapped(String item, StateSetter setModalState) async {}

  void _onChipDeleted(String item, StateSetter setModalState) async {
    List<String> items = await _optionslist;
    setModalState(() {
      widget.chosenItemsList.value.remove(item);
      _suggestions =
          getSuggestionsWithoutChosen(items, widget.chosenItemsList.value);
    });
    widget.updatevalue();
  }

  void _onSubmitted(String text, StateSetter setModalState) async {
    List<String> items = await _optionslist;
    if (widget.chosenItemsList.value.length < defaultMaxLabels) {
      if (text.trim().isNotEmpty) {
        setModalState(() {
          widget.chosenItemsList.value = <String>[
            ...widget.chosenItemsList.value,
            text.trim()
          ];
        });
      }
      setModalState(() {
        _suggestions =
            getSuggestionsWithoutChosen(items, widget.chosenItemsList.value);
      });
      widget.updatevalue();
    } else {}
  }

  void _onChanged(List<String> data, StateSetter setModalState) {
    setModalState(() {
      widget.chosenItemsList.value = data;
      _chipFocusNode.unfocus();
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) async {
    List<String> items = await _optionslist;
    if (text.isNotEmpty || text.trim() != "") {
      return items.where((String item) {
        return item.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return items;
  }

  List<String> getSuggestionsWithoutChosen(
      List<String> allItems, List<String> chosenItems) {
    return allItems
        .where((String item) => !chosenItems.contains(item))
        .toList();
  }
}
