import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivetut/employee.dart';

class HiveDataBaseService extends ChangeNotifier {
  List<Employee> listEmployees = [];

  addExpense(Employee employee) async {
    var box = await Hive.openBox<Employee>('employee');
    box.add(employee);
    notifyListeners();
  }


  getEmployees() async {
    final box = await Hive.openBox<Employee>('employee');
    listEmployees = box.values.toList();
    notifyListeners();
  }
}
