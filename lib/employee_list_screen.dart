import 'package:flutter/material.dart';
import 'package:hivetut/Provider/data_base_provider.dart';
import 'package:hivetut/add_or_edit_employee_screen.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HiveDataBaseService>(
        create: (context) => HiveDataBaseService(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddOrEditEmployeeScreen(false)),
                  )),
          body: Consumer<HiveDataBaseService>(builder: (context, data, child) {
            return ListView.builder(
                itemCount: data.listEmployees.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(
                    data.listEmployees[index].empName,
                  ));
                });
          }),
        ));
  }
}
