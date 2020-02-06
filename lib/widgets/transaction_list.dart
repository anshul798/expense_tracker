import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/1.55,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transactions Added Yet',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                final item=transactions[index].title;
                return Dismissible(
                  key: Key(item),
                  onDismissed: (direction){
                    deleteTx(item,index);
                  },
                  background: Container(color: Colors.red,),

                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text('\$${transactions[index].amount}'))),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: (){

                        },
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
