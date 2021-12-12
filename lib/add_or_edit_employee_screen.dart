import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'Provider/data_base_provider.dart';
import 'employee.dart';
import 'employee_list_screen.dart';

class AddOrEditEmployeeScreen extends StatefulWidget {
  bool isEdit;
  int position;
  Employee employeeModel;

  AddOrEditEmployeeScreen(this.isEdit, [this.position, this.employeeModel]);

  @override
  State<StatefulWidget> createState() {
    return AddEditEmployeeState();
  }
}

class AddEditEmployeeState extends State<AddOrEditEmployeeScreen> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSalary = TextEditingController();
  TextEditingController controllerAge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      controllerName.text = widget.employeeModel.empName;
      controllerSalary.text = widget.employeeModel.empSalary.toString();
      controllerAge.text = widget.employeeModel.empAge.toString();
    }

    return SafeArea(
      child: ChangeNotifierProvider<HiveDataBaseService>(
        create: (context) => HiveDataBaseService(),
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(25),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Employee Name:", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(controller: controllerName),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Employee Salary:",
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                        controller: controllerSalary,
                        keyboardType: TextInputType.number),
                  )
                ],
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text("Employee Age:", style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                        controller: controllerAge,
                        keyboardType: TextInputType.number),
                  )
                ],
              ),
              const SizedBox(height: 100),
              Consumer<HiveDataBaseService>(builder: (context, data, child) {
                return RaisedButton(
                  color: Colors.grey,
                  child: const Text("Submit",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () async {
                    var getEmpName = controllerName.text;
                    var getEmpSalary = controllerSalary.text;
                    var getEmpAge = controllerAge.text;
                    if (getEmpName.isNotEmpty &&
                        getEmpSalary.isNotEmpty &&
                        getEmpAge.isNotEmpty) {
                      if (widget.isEdit) {
                        Employee updateEmployee = Employee(
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge);
                        data.editEmployee(widget.position, updateEmployee);
                      } else {
                        Employee addEmployee = Employee(
                            empName: getEmpName,
                            empSalary: getEmpSalary,
                            empAge: getEmpAge);

                        data.addExpense(addEmployee);
                        print(addEmployee);
                      }
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => EmployeeListScreen()),
                          (r) => false);
                    }
                  },
                );
              })
            ]),
          ),
        )),
      ),
    );
  }
}
