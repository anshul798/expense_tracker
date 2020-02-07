import 'package:flutter/foundation.dart';
class Transaction {
   int Id;
   String id;
   String title;
   double amount;
   DateTime date;

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date
  });


  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{
      'id':Id,
      'title':title,
      'amount':amount,
      'date':date
    };
    return map;
  }

  Transaction.fromMap(Map<String, dynamic> map){
    Id = map['id'];
    title =  map['title'];
    amount = map['amount'];
    date = map['date'];
  }
}
