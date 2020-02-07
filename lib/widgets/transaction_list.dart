import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.55,
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
                final item = transactions[index].title;
                return Dismissible(
                  key: Key(item),
                  confirmDismiss: (DismissDirection direction) async {
                    final bool res = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text("Are you sure you wish to delete this item?"),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                  deleteTx(item, index);

                                },
                                child: const Text("DELETE")
                            ),
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("CANCEL"),
                            ),
                          ],
                        );
                      },
                    );
                    if(res) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 2),
                        content: Text("$item Deleted"),
                      ));
                      return true;

                    }else return false;
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.amber[700],
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text("Item Name: $item"),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)
                      ),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                  child:
                                      Text('\$${transactions[index].amount}'))),
                        ),
                        title: Text(
                          transactions[index].title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd().format(transactions[index].date),
                        ),
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
