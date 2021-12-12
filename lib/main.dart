import 'dart:io';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'Provider/data_base_provider.dart';
import 'employee.dart';
import 'employee_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(EmployeeAdapter());
  runApp(MyApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HiveDataBaseService>(
          create: (context) => HiveDataBaseService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmployeeListScreen(),
      ),
    );
  }
}
