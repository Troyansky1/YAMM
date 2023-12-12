import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yamm_app/transaction_controllers.dart';
import 'dart:async';

final List<String> labels = <String>[
  'a',
  'aa',
  'aab',
  'aabb',
  'Shopping',
  'Car',
  'House',
  'Birthday',
  'Alcohol',
];

class LableEntry extends StatefulWidget {
  //final Widget child;
  final TransactionControllers controllers;
  const LableEntry({super.key, required this.controllers});

  @override
  State<LableEntry> createState() => _LableEntryState();
}

class _LableEntryState extends State<LableEntry> {
  final FocusNode _chipFocusNode = FocusNode();
  List<String> _enteredLables = <String>[];
  //List<String> _lables = <String>[];
  List<String> _suggestions = <String>[];
  VoidCallback? _showPersBottomSheetCallBack;
  final ExpansionTileController controller = ExpansionTileController();

  @override
  void initState() {
    super.initState();
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
                        values: _enteredLables,
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: _suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LableSuggestions(
                              _suggestions[index],
                              onTap: (String str) {
                                _selectSuggestion(str, setModalState);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            );
          });
        });
    return _enteredLables;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 200,
      width: 500,
      child: Column(
        children: <Widget>[
          Row(
            children: List<Widget>.generate(
              _enteredLables.length,
              (int index) {
                String lable = _enteredLables[index];
                return InputChip(
                  label: Text('#$lable'),
                  labelPadding: EdgeInsets.all(1),
                  onDeleted: () {
                    _onChipDeleted(lable, setState);
                  },
                  onSelected: (bool True) {
                    _onChipTapped(lable, setState);
                  },
                );
              },
            ).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              _showModalSheet();
            },
            child: const Text("Add labels"),
          ),
        ],
      ),
    );
  }

  Future<void> _onSearchChanged(String value, StateSetter setModalState) async {
    final List<String> results = await _suggestionCallback(value);
    setModalState(() {
      _suggestions = results
          .where((String lable) => !_enteredLables.contains(lable))
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
      _enteredLables.add(lable);
      _suggestions = <String>[];
    });
    setState(() {
      _enteredLables = _enteredLables;
    });
  }

  void _onChipTapped(String lable, StateSetter setModalState) {}

  void _onChipDeleted(String lable, StateSetter setModalState) {
    setModalState(() {
      _enteredLables.remove(lable);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text, StateSetter setModalState) {
    if (text.trim().isNotEmpty) {
      setModalState(() {
        _enteredLables = <String>[..._enteredLables, text.trim()];
      });
      setState(() {
        _enteredLables = _enteredLables;
      });
    } else {
      setModalState(() {
        _suggestions = <String>[];
      });
      setState(() {
        _enteredLables = _enteredLables;
      });
    }
  }

  void _onChanged(List<String> data, StateSetter setModalState) {
    setModalState(() {
      _enteredLables = data;
      _chipFocusNode.unfocus();
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return labels.where((String lable) {
        return lable.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
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
      leading: CircleAvatar(
        child: Text(
          lable[0].toUpperCase(),
        ),
      ),
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
