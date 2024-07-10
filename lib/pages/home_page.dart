
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/expense_summary.dart';
import '../components/list_tile.dart';
import '../data/expense_data.dart';
import '../models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final expenseNameController=TextEditingController();
  final expenseAmountController=TextEditingController();
@override
  void initState(){
    super.initState();
//prepare data for startup


Provider.of<ExpenseData>(context,listen: false).prepareData();

  }

  void addNewExpense(){
    showDialog(
        context: context,
        builder:(context)=>AlertDialog(
          title: Text("Add a new expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //Expense Name
              TextField(
                controller: expenseNameController,
                decoration: InputDecoration(
                  hintText: "Expense name",
                ),
              ),

              //Expense amount
              TextField(
                keyboardType: TextInputType.number,
                controller: expenseAmountController,
                decoration: InputDecoration(
                  hintText: "Expense amount"
                ),
              )
            ],
          ),
          actions: [
            //cancel button

            MaterialButton(
                onPressed: cancel,
              child: Text("Cancel"),
            ),


            //Save button
            MaterialButton(
                onPressed: save,
              child: Text("Save"),
            )

          ],
        )
    );
  }
  //delete the expense

  void deleteExpense(ExpenseItem expense){
  Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  void save(){
    if(expenseNameController.text.isNotEmpty && expenseAmountController.text.isNotEmpty){
      ExpenseItem newExpense=ExpenseItem(
          name: expenseNameController.text,
          amount: expenseAmountController.text,
          dateTime: DateTime.now()
      );
      Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
    }
    Navigator.pop(context);
    clear();

  }

  void cancel(){
    Navigator.pop(context);
    clear();
  }
  void clear(){
    expenseAmountController.clear();
    expenseNameController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context,value,child)=>Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(Icons.add,color: Colors.white,),
            backgroundColor: Colors.black,
          ),
          body: ListView(
            children: [
              //Weekly summary
              SizedBox(height: 10,),
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: value.getExpenseList().length,
                itemBuilder: (context,index)=>MyListTile(
                    name: value.getExpenseList()[index].name,
                    amount: value.getExpenseList()[index].amount,
                    dateTime: value.getExpenseList()[index].dateTime,
                  deleteTapped: (p0)=>deleteExpense(value.getExpenseList()[index]),
                ),
              ),
            ],



          )
          ),
        );

  }
}
