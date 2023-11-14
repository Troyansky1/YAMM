import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yamm_app/Transaction.dart';


enum RepeatOptions {
  noRepeat('Does not repeat'),
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly'),
  yearly('Yearly');

  const RepeatOptions(this.label);
  final String label;
}

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  final String title = "Add a transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  Transaction newTransaction = Transaction();

  //Input controllers
  var amountCont = TextEditingController(); 
  var titleCont = TextEditingController(); 
  var isOutcomeCont = TextEditingController();
  var dateCont = TextEditingController(); 
  var serviceProviderCont = TextEditingController(); 
  var repeatOptionCont = TextEditingController();

  bool repeat = false;
  bool isIncome = true;
  List<bool> _incomeOutcome = [true, false];
  

  void setIncomeOutcome(int indexToToggle){
    // Presses the current button and unpresses the other button. Does nothing if button is pressed.
    int index = indexToToggle;
    setState(() {
      if (!_incomeOutcome[index]){
        _incomeOutcome[index] = !_incomeOutcome[index];  
        _incomeOutcome[(index+1)%2] = !_incomeOutcome[index];  
      } 
    });  
  }

  void setRepeat(RepeatOptions? repeat){
    setState(() {
      if (repeat != RepeatOptions.noRepeat){
        
      }
    });
  }

  
  @override
  void initState() {
    amountCont.text = ""; //set the initial value of text field
    super.initState();
  }
 
 @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<RepeatOptions>> RepeatOptionsEntries =
        <DropdownMenuEntry<RepeatOptions>>[];
    for (final RepeatOptions repeatOption in RepeatOptions.values) {
      RepeatOptionsEntries.add(DropdownMenuEntry<RepeatOptions>(label: repeatOption.label, value: repeatOption),);}
      
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[ 
            Text(
              'Enter a transaction',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Amount'),
              keyboardType: TextInputType.number
            ),  
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Title'),
            ),  
            TextField(
              controller: dateCont,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today), 
                labelText: 'Date'),
                readOnly: true,
                onTap: () async{
                  DateTime? pickedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(), 
                    firstDate: DateTime(2000), 
                    lastDate:DateTime(2101)
                    );
                    
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('dd/MM/yy').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16                      
                      setState(() {
                         dateCont.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ), 
               
            ElevatedButton.icon(
              
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context)=> AlertDialog(
                    title: Text("Repeat options"),
                    content: 
                      DropdownMenu<RepeatOptions>(
                        leadingIcon: const Icon(Icons.repeat),
                        initialSelection: RepeatOptions.noRepeat,
                        controller: repeatOptionCont,
                        dropdownMenuEntries: RepeatOptionsEntries,
                        inputDecorationTheme: const InputDecorationTheme(
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                      ),
              onSelected: (RepeatOptions? repeat) => setRepeat(repeat),
              ), 
                  ),);
              },
              icon: const Icon( Icons.repeat, size: 24.0, ),
              label: const Text('Repeat'), // <-- Text
            ),  
            
              
            ToggleButtons(
              constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 36) / 3),              
              onPressed: (int index) => setIncomeOutcome(index),
              isSelected: _incomeOutcome,
            borderRadius: BorderRadius.circular(40),
            borderWidth: 5,
            children: const [
              Text("Income"),
              Text("Outcome")
            ],
            ),
                   
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Service provider'),
            ),         


          ],
        ),
      ),
      
    );
  }
}

