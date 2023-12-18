import 'package:flutter/material.dart';

class testPage extends StatefulWidget {
  const testPage({super.key});

  @override
  State<testPage> createState() => _MytestPageState();
}

class _MytestPageState extends State<testPage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home page"),
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Text("Test"),
        ],
      )),
    );
  }
}
