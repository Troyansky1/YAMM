import 'package:flutter/material.dart';
import 'package:yamm_app/category_enum.dart';
import 'package:yamm_app/functions/preferences.dart';
import 'package:yamm_app/transaction_entries/transaction_entries.dart';

class filterSideSheet extends StatefulWidget {
  const filterSideSheet({super.key});

  @override
  State<filterSideSheet> createState() => _filterSideSheetState();
}

class _filterSideSheetState extends State<filterSideSheet> {
  late Map<TransactionCategory, bool> categoriesFIlters = {};
  late Map<String, bool> labelsFIlters = {};
  final Future<List<String>> labels = getLabels();
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  @override
  void initState() {
    for (TransactionCategory category in TransactionCategory.values) {
      categoriesFIlters[category] = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          floating: false,
          snap: false,
          forceElevated: true,
          expandedHeight: 50.0,
          flexibleSpace: FlexibleSpaceBar(
            title:
                Text('Filter options', style: TextStyle(color: Colors.black)),
          ),
        ),
        FutureBuilder<String>(
          future: _calculation, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                SliverList.builder(
                    itemCount: categoriesFIlters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue,
                        child: SwitchListTile(
                          value: categoriesFIlters[
                              TransactionCategory.values[index]]!,
                          title: Text(TransactionCategory.values[index].name),
                          onChanged: (bool? value) {
                            setState(() {
                              categoriesFIlters[
                                  TransactionCategory.values[index]] = value!;
                            });
                          },
                        ),
                      );
                    }),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ],
    );
  }
}
