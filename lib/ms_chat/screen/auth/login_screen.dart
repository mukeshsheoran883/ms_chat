import 'package:flutter/material.dart';
import 'package:ms_chat/main.dart';
import 'package:ms_chat/ms_chat/screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
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
            AnimatedPositioned(
              top: mq.height * .15,
              width: mq.width * .5,
              right:_isAnimate ? mq.width * .25 : -mq.width * .5,
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/chating.png'),
            ),
            Positioned(
              bottom: mq.height * .15,
              width: mq.width * .9,
              left: mq.width * .05,
              height: mq.height * .05,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent[200]),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                icon: Image.asset('assets/images/google.png',
                    height: mq.height * 0.03),
                label: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                      TextSpan(text: 'Login with '),
                      TextSpan(
                          text: 'Google',
                          style: TextStyle(fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
