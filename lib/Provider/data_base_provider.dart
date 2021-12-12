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

  Future getEmployees() async {
    final box = await Hive.openBox<Employee>('employee');
    listEmployees = box.values.toList();
    notifyListeners();
  }

  deleteEmployee(int position) async {
    final box = Hive.box<Employee>('employee');
    box.deleteAt(position);
    listEmployees.removeAt(position);

    notifyListeners();
  }

  editEmployee(int position, Employee employee) async {
    var box = await Hive.openBox<Employee>('employee');
    box.putAt(position, employee);
    notifyListeners();
  }
}
