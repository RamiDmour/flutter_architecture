import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/app.dart';
import 'package:flutter_architecture/core/di/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItSetup();

  runApp(App());
}
