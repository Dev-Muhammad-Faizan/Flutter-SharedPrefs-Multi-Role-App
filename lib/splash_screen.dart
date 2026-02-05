import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sessionflow/login_screen.dart';
import 'package:sessionflow/admin_screen.dart';
import 'package:sessionflow/student_screen.dart';
import 'package:sessionflow/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;
    String selectedRole=sp.getString('role')??'';
    await Future.delayed(Duration(seconds: 3));

    if(isLogin && selectedRole=='Student')
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentScreen()),
        );
      }
    else if(isLogin && selectedRole=='Teacher')
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherScreen()),
        );
      }
    else if(isLogin && selectedRole=='Admin')
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      }
    else
      {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            height: double.infinity,
            fit: BoxFit.fitHeight,
            image: NetworkImage(
              'https://tse1.mm.bing.net/th/id/OIP.xgNqw4utp_IWPAqFQMDnGwHaKo?rs=1&pid=ImgDetMain&o=7&rm=3',
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
