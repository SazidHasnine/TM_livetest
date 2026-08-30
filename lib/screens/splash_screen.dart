import 'package:flutter/material.dart';
import 'package:tm_live_test/screens/task_list_screen.dart';


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
    moveToNextScreen();
  }

  Future<void> moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TaskListScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.png', height: 220, width: 220),
              SizedBox(height: 20,),
              Text('Wait a moment...', style: TextStyle(fontSize: 18, color: Colors.black),),
              // Text('Taking to your app'),
              CircularProgressIndicator(),
            ]
        ),
      ),
    );
  }
}
