import 'package:flutter/material.dart';
import 'package:flutter_application_5/views/splashscreen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
   Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Barterlt',  
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch:Colors.orange,),
          home: const SplashScreen(),       
        
        )   ;
  }
}
