import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:notes_new_app/Pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: 110),
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "Welcome to MindPad",
              decoration: PageDecoration(titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xff3f51b5))),
              body: "Jot down your ideas, thoughts, and important moments instantly. MindPad helps you clear your mind and stay organized, all in one place.",
              image: SvgPicture.asset('Assets/welcome.svg',height: 200,width: 200,),
            ),
            PageViewModel(
              title: "Capture What Matters",
              decoration: PageDecoration(titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xff3f51b5))),
              body: "Create notes, organize your thoughts, and keep track of everything that matters—whether it’s a quick idea or a detailed plan.",
              image: SvgPicture.asset('Assets/important.svg',height: 200,width: 200,),
            ),
            PageViewModel(
              title: "Your Mind. Your Space",
              decoration: PageDecoration(titleTextStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xff3f51b5))),
              body: "Stay productive, stress-free, and in control. MindPad is your personal space to think, plan, and achieve your goals without distractions.",
              image: SvgPicture.asset('Assets/productive.svg',height: 200,width: 200,),
            ),
          ],
          onDone: () => movetoend(),
          onSkip: () => movetoend(),
          showSkipButton: true,
          skip: const Text("Skip", style: TextStyle(fontWeight: FontWeight.bold)),
          next: const Icon(Icons.arrow_forward),
          done: const Text(
            "Finish",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            color: Colors.grey,
            activeSize: Size(22.0, 10.0),
            activeColor: Colors.blue,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }

  movetoend() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro_seen', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
