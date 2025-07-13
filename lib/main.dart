import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:work_manager/app.dart';

import 'config/string.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(AppStr.hiveBoxName);
  runApp(const App());
}
