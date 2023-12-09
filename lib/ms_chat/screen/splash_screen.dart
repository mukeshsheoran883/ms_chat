import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ms_chat/main.dart';
import 'package:ms_chat/ms_chat/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Welcome to Ms Chat'),
        ),
        body: Stack(
          children: [
            Positioned(
              top: mq.height * .15,
              width: mq.width * .5,
              right: mq.width * .25,
              child: Image.asset('assets/images/chating.png'),
            ),
            Positioned(
                bottom: mq.height * .15,
                width: mq.width,
                child: const Text(
                  textAlign: TextAlign.center,
                  "MADE IN INDIA WITH ❤️",
                  style: TextStyle(
                      fontSize: 16, color: Colors.black87, letterSpacing: .5),
                )),
          ],
        ),
      ),
    );
  }
}