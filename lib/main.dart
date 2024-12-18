import 'package:flutter/material.dart';
import 'package:jarvis/app/app.dart';
import 'package:jarvis/app/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}
