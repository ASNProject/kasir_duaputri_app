import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kasir_duaputri_app/routes/app_routes.dart';
import 'package:window_size/window_size.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
    );
  }
}
