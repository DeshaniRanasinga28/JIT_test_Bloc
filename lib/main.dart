import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jit_transfer_app/bloc/user_block.dart';
import 'package:jit_transfer_app/ui/splash/splash_screen.dart';
import 'package:jit_transfer_app/ui/splash/splash_screen_wrapper.dart';

import 'bloc/transaction_bloc.dart';


final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBlock()),
        BlocProvider(create: (context) => TransactionBloc()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.black,
        ),
        home: const SplashScreenWrapper(),
        // home: const SplashScreen(),
      ),
    );
  }
}







