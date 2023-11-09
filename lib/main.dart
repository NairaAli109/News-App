import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/shared/bloc_observer.dart';

void main() {

  // ErrorWidget.builder=(details)=>MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: Scaffold(
  //     backgroundColor: Colors.purple,
  //     body: SizedBox.expand(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Icon(
  //               Icons.warning_rounded,
  //             color: Colors.white,
  //             size: 50,
  //           ),
  //           const SizedBox(height: 10,),
  //           Text(
  //             details.exception.toString(),
  //             style: const TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   ),
  // );

  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                  color: Colors.deepOrange,
                  size: 30
              )
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.deepOrange,
            elevation: 20.0,
          )
      ),
      home:  const HomeScreen(),
    );
  }
}
