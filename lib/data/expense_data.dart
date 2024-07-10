import 'dart:core';


import 'package:flutter/cupertino.dart';

import '../helper/date_time_helper.dart';
import '../models/expense_item.dart';
import 'hive_database.dart';

class ExpenseData extends ChangeNotifier{
  //List of all expense
  List<ExpenseItem> overallExpenseItem=[];





  //Get expense list
List<ExpenseItem> getExpenseList(){
  return overallExpenseItem;
}

  final db=HiveDatabase();
//prepare data to display
  void prepareData(){
  //if there exist data.get it

    if(db.readData().isNotEmpty){
      overallExpenseItem=db.readData();
    }
  }












//Add Expense

void addNewExpense(ExpenseItem newExpense){
  overallExpenseItem.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseItem);
}

//delete expense

void deleteExpense(ExpenseItem expense){
  overallExpenseItem.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseItem);
}

//Get which day

String getDayName(DateTime dateTime){
  switch(dateTime.weekday){
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    case 7:
      return "Sun";
      default: return" ";
  }
}

//get the date for the start of week
  DateTime startOfWeekDate() {
    DateTime? startofWeek;
// get todays date
    DateTime today = DateTime.now();
// go backwards from today to find sunday
    for (int i = 0; i < 7; i++) {
      if(getDayName(today.subtract(Duration(days: i)))=="Sun"){
        startofWeek = today.subtract(Duration(days: i));
    }

    }
    return startofWeek!;
    }

    Map<String, double> calculateDailyExpenseSummary(){
  Map<String,double> dailyExpenseSummary={
  };

    for(var expense in overallExpenseItem){
      String date=convertDateTimeToString(expense.dateTime);
      double amount=double.parse(expense.amount);
      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount=dailyExpenseSummary[date]!;
        currentAmount=currentAmount + amount;
        dailyExpenseSummary[date]=currentAmount;
      }
      else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;

    }







}