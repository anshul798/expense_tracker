import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now(),)
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: 'Title',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      titleController.clear();
                    },
                  ),
                ),
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: Theme.of(context).primaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelText: 'Amount',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      amountController.clear();
                    },
                  ),
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),

              Container(
                height: 70,
                child: Row(
                  children: <Widget>[

                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 40,
                child: RaisedButton(

                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Text('Add Transaction'),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button.color,
                    onPressed: _submitData),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
