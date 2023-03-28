
import 'package:fetch_api/pages/form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255,255,240,141),
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 9, 49, 27),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
              shape:  RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(10) 
            ),
            backgroundColor: const Color.fromARGB(255,255,168,106)
            
          )
        ),
        inputDecorationTheme: InputDecorationTheme(border: OutlineInputBorder(borderRadius:BorderRadius.circular(10) ),filled: true,
        fillColor: const Color.fromARGB(255,255,245,177 )

        )
        
        
      ),
      home: const FormPage(),
    );
  }
}

