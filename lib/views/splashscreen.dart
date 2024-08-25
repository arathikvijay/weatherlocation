import 'package:flutter/material.dart';
import 'package:weather_location/views/home_screen.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<splash> {
  @override
  void initState(){
    super.initState();
    print("InIt State Is Initialized");
    navigateToNextScreen();
    
  }
  void navigateToNextScreen()async{
    await Future.delayed(Duration(seconds: 2));
   // final bool islogin=await gettingRegBool();
    //if(islogin) {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const home_screen(),));
    //}


  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Image.asset("assets/images/Sun cloud angled rain.png")),
    );
  }
}