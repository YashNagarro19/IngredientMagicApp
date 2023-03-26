import 'package:flutter/material.dart';

import 'home_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Hackathon Demo',
      debugShowCheckedModeBanner: false,
      theme:  ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[8],
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(fontSize: 20 ),

            ), ),
        appBarTheme: const AppBarTheme(titleTextStyle : TextStyle(fontSize: 26.0,  fontWeight: FontWeight.bold,   fontFamily: 'Hind',),),
        fontFamily: 'Hind',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 62.0, fontWeight: FontWeight.bold, ),
          titleLarge: TextStyle(fontSize: 32.0,),
          bodyMedium: TextStyle(fontSize: 16.0,),
          bodyLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),
        ),
      ),
      home: HomePage(),
    );
  }
}






