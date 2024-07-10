import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyListTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  MyListTile({super.key,required this.name,required this.amount,required this.dateTime,required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
              onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(dateTime.day.toString()+ '/' +dateTime.month.toString() +'/'+ dateTime.year.toString()),
        trailing: Text('Rs'+amount,style: TextStyle(fontSize: 18),),
      ),
    );
  }
}
