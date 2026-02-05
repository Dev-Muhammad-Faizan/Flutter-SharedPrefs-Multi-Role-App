import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sessionflow/admin_screen.dart';
import 'package:sessionflow/student_screen.dart';
import 'package:sessionflow/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final rolecontroller = TextEditingController();
  String? selectedRole;
  auth() async {
    if (emailcontroller.text.trim().isEmpty ||
        passwordcontroller.text.trim().isEmpty || selectedRole==null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Fill all the Details')));
    } else {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('email', emailcontroller.text.toString());
      sp.setString('password', passwordcontroller.text.toString());
      sp.setString('role', selectedRole ?? 'Student');
      sp.setBool('isLogin', true);
      if(selectedRole=='Student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StudentScreen()),
        );
      }
      else if(selectedRole=='Teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeacherScreen()),
        );
      }
      else if(selectedRole=='Admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                fillColor: Colors.greenAccent[100],
                filled: true,
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                fillColor: Colors.greenAccent[100],
                filled: true,
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_outlined),
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: Colors.greenAccent[100],
                filled: true,
                labelText: 'Role',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              value: selectedRole,
              items: ['Student', 'Teacher', 'Admin']
                  .map(
                    (role) => DropdownMenuItem(value: role, child: Text(role)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {});
                selectedRole = value;
              },
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                auth();
              },
              child: Container(
                height: 50,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.greenAccent,
                ),
                child: Center(child: Text('data')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
