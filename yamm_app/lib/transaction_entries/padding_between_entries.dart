import 'package:flutter/material.dart';

class EntriesPadding extends StatefulWidget {
  const EntriesPadding({super.key});

  @override
  State<EntriesPadding> createState() => _EntriesPaddingState();
}

class _EntriesPaddingState extends State<EntriesPadding> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: SizedBox(
        height: 0,
        width: 100,
      ),
    );
  }
}
