import 'package:flutter/material.dart';


class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  final String title = "Add a transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
 
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[          
            Text(
              'temp text',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      
    );
  }
}

