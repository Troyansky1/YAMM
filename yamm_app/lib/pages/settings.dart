import 'package:flutter/material.dart';
import 'package:yamm_app/functions/actions_on_list.dart';
import 'package:yamm_app/functions/dialogs.dart';
import 'package:yamm_app/functions/csv_handling.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Debug actions"),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading:
                        const Icon(Icons.delete_forever, color: Colors.red),
                    title: Text(
                      "Delete database forever",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      uSureBroDialog(
                          context,
                          const Text(
                              'Are you sure you want to permanently delete the entire database?'),
                          deleteCsv);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  ListTile(
                    leading: const Icon(Icons.ios_share_outlined),
                    title: Text(
                      "Export list",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Export to downloads folder",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      exportList();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
