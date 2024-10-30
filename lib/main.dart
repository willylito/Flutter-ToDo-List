import 'package:flutter/material.dart';
import 'package:todo_list/src/di.dart';
import 'package:todo_list/src/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const BlocProviders());
}
