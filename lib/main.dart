import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasir_duaputri_app/auth/auth_get.dart';
import 'package:kasir_duaputri_app/bloc/cart_bloc.dart';
import 'package:kasir_duaputri_app/firebase_options.dart';
import 'package:kasir_duaputri_app/presentation/bloc_observer.dart';
import 'package:window_size/window_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(create: (BuildContext context) => CartBloc())
        ],
        child: const MaterialApp(
          home: AuthGet(),
        ));
    // MaterialApp.router(
    //   routerConfig: appRoutes,
    // );
  }
}
