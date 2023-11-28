import 'package:flutter/material.dart';

class EntriesPadding extends StatefulWidget {
  const EntriesPadding({super.key});

  @override
  State<EntriesPadding> createState() => _EntriesPaddingState();
}

class _EntriesPaddingState extends State<EntriesPadding> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 2,
        width: 100,
      ),
    );
  }
}
