import 'package:flutter/material.dart';
import 'package:yamm_app/functions/dialogs.dart';
import 'package:yamm_app/functions/save_and_load_csv.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        const Icon(Icons.delete_forever, color: Colors.red),
                    title: const Text("-Debug-"),
                    subtitle: const Text("Delete database forever"),
                    onTap: () {
                      uSureBroDialog(
                          context,
                          const Text(
                              'Are you sure you want to permanently delete the entire database?'),
                          deleteCsv);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
