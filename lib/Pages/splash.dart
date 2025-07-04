import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_new_app/Pages/homepage.dart';
import 'package:notes_new_app/Pages/intropage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectpage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset('Assets/notes_splash.svg',height: 300,width: 300,)),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text('MindPad',style: GoogleFonts.acme(fontSize: 50,fontWeight: FontWeight.bold,color: Color(0xff3f51b5)),),
          )
        ],
      ),
    );
  }
  selectpage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('intro_seen') ?? false;
    Timer(Duration(seconds: 7), (){
      value == false ? moveintro() : movehome();
    });
  }
  moveintro(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>IntroPage()));
  }
  movehome(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
  }
}