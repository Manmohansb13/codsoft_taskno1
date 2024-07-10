import 'package:hive/hive.dart';

import '../models/expense_item.dart';

class HiveDatabase{
  //reference our box from void main
  final _myBox=Hive.box("expense_database");


  //writer data
void saveData(List<ExpenseItem> allExpense){
  List<List<dynamic>> allExpensesFormatted = [];
  for(var expense in allExpense){
    List<dynamic> expenseFormatted=[
      expense.name,
      expense.amount,
      expense.dateTime,
    ];
    allExpensesFormatted.add(expenseFormatted);
  }
  _myBox.put("ALL_EXPENSES", allExpensesFormatted);
}




  //read data
List<ExpenseItem> readData(){
  List savedExpenses=_myBox.get("ALL_EXPENSES")??[];
  List<ExpenseItem> allExpenses=[];

  for(int i=0;i<savedExpenses.length;i++){
    String name=savedExpenses[i][0];
    String amount=savedExpenses[i][1];
    DateTime dateTime=savedExpenses[i][2];
    //Create expense item

    ExpenseItem expense=ExpenseItem(name: name, amount: amount, dateTime: dateTime);
    allExpenses.add(expense);
  }
  return allExpenses;

}





}