import 'package:flutter/material.dart';
import 'package:restaurant_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(await App.create());
}
