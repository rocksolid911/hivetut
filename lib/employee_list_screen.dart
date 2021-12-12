import 'package:flutter/material.dart';
import 'package:hivetut/Provider/data_base_provider.dart';
import 'package:hivetut/add_or_edit_employee_screen.dart';
import 'package:hivetut/employee.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDataBaseService>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Hive with Provider"),
          ),
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddOrEditEmployeeScreen(false)),
                  )),
          body: FutureBuilder(
            future: data.getEmployees(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: data.listEmployees.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Card(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white)),
                      elevation: 4.0,
                      child: ListTile(
                        title: Text(data.listEmployees[index].empName),
                        subtitle: Text(data.listEmployees[index].empSalary),
                        trailing: InkWell(

                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.delete),
                          ),
                          onTap: () {
                            data.deleteEmployee(index);
                          },
                        ),
                        leading: InkWell(
                          child: const CircleAvatar(
                            child: Icon(Icons.edit),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddOrEditEmployeeScreen(
                                    true, index, data.listEmployees[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
