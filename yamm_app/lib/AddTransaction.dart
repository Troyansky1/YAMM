import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});
  final String title = "Add a transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
 TextEditingController dateinput = TextEditingController(); 
 var isOutcomeController = TextEditingController();

 final List<bool> _selections = [true, false];
  
  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }
 
 @override
  Widget build(BuildContext context) {
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
              controller: dateinput,
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
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
            ),
            ToggleButtons(
              constraints: BoxConstraints(minWidth: (MediaQuery.of(context).size.width - 36) / 3),
              isSelected: _selections,
              onPressed: (int index){
              setState(() {
                _selections[index] = !_selections[index];
                _selections[(index+1)%2] = !_selections[index];
              });
            },
            borderRadius: BorderRadius.circular(40),
            borderWidth: 5,
            children: const [
              Text("Income"),
              Text("Outcome")
            ],
            ),
            TextField(
              controller: isOutcomeController,
              decoration: InputDecoration(
                //border: OutlineInputBorder(), 
                labelText: 'Outcome or income?',
                suffixIcon: IconButton(
                  onPressed: isOutcomeController.clear,
                  icon: const ImageIcon(AssetImage("assets/icons/income.png")),)
    ),
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

