import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'package:yamm_app/functions/preferences.dart';
import 'dart:async';

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
  VoidCallback? _showPersBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _labels = getLabels();
    _showPersBottomSheetCallBack = () {
      _showModalSheet();
    };
  }

  _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              color: const Color.fromARGB(255, 195, 221, 215),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ChipsInput<String>(
                        values: widget.controllers.labels,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.local_pizza_rounded),
                        ),
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
    final TextTheme textTheme = Theme.of(context).textTheme;
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
      onPressed: () {
        _showModalSheet();
      },
      child: const Text("Add labels"),
    ));
    return chosenLabels;
  }

  Future<void> _onSearchChanged(String value, StateSetter setModalState) async {
    final List<String> results = await _suggestionCallback(value);
    setModalState(() {
      _suggestions = results
          .where((String lable) => !widget.controllers.labels.contains(lable))
          .toList();
    });
  }

  Widget _chipBuilder(
      BuildContext context, String lable, StateSetter setModalState) {
    return ToppingInputChip(
      lable: lable,
      onDeleted: (String str) {
        _onChipDeleted(str, setModalState);
      },
      onSelected: (String str) {
        _onChipTapped(str, setModalState);
      },
    );
  }

  void _selectSuggestion(String lable, StateSetter setModalState) {
    setModalState(() {
      widget.controllers.labels.add(lable);
      _suggestions = <String>[];
    });
    setState(() {
      widget.controllers.labels = widget.controllers.labels;
    });
  }

  void _onChipTapped(String lable, StateSetter setModalState) {}

  void _onChipDeleted(String lable, StateSetter setModalState) {
    setModalState(() {
      widget.controllers.labels.remove(lable);
    });
    setState(() {
      widget.controllers.labels = widget.controllers.labels;
    });
  }

  void _onSubmitted(String text, StateSetter setModalState) {
    if (text.trim().isNotEmpty) {
      setModalState(() {
        widget.controllers.labels = <String>[
          ...widget.controllers.labels,
          text.trim()
        ];
      });
      setState(() {
        widget.controllers.labels = widget.controllers.labels;
      });
    } else {
      setModalState(() {
        _suggestions = <String>[];
      });
      setState(() {
        widget.controllers.labels = widget.controllers.labels;
      });
    }
  }

  void _onChanged(List<String> data, StateSetter setModalState) {
    setModalState(() {
      widget.controllers.labels = data;
      _chipFocusNode.unfocus();
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) async {
    List<String> labels = await _labels;
    if (text.isNotEmpty) {
      return labels.where((String lable) {
        return lable.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return labels;
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    super.key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  });

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  @visibleForTesting
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
        values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class LableSuggestions extends StatelessWidget {
  const LableSuggestions(this.lable, {super.key, this.onTap});

  final String lable;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(lable),
      title: Text(lable),
      onTap: () => onTap?.call(lable),
    );
  }
}

class ToppingInputChip extends StatelessWidget {
  const ToppingInputChip({
    super.key,
    required this.lable,
    required this.onDeleted,
    required this.onSelected,
  });

  final String lable;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: InputChip(
        key: ObjectKey(lable),
        label: Text(lable),
        avatar: CircleAvatar(
          child: Text(lable[0].toUpperCase()),
        ),
        onDeleted: () => onDeleted(lable),
        onSelected: (bool value) => onSelected(lable),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2),
      ),
    );
  }
}
