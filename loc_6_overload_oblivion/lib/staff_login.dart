import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/resources/auth_methods.dart';
import 'package:loc_6_overload_oblivion/staff_signup.dart';
import 'package:loc_6_overload_oblivion/user_type_selection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _staffIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _staffIdController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethod = AuthMethods();
    void login() async {
      String res = await authMethod.loginUser(
          email: _emailController.text,
          password: _passwordController.text,
          staffid: _staffIdController.text);
      if (res != 'Success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Scaffold(),
          ),
        );
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Image1.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            
            left:10,
            top:25,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
              onPressed: () {
                Navigator.of(context).pop();
        
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 2),
              // Login Box
              Center(
                child: Container(
                  width: 311,
                  height: 513,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(26, 25, 53, 0.74),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: 281,
                        height: 48,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _staffIdController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(8, 17, 40, 1),
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            hintText: "Enter you Staff ID",
                            labelText: "Staff ID",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: 281,
                        height: 48,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(8, 17, 40, 1),
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            hintText: "Enter your email",
                            labelText: "E-mail",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 281,
                        height: 48,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromRGBO(8, 17, 40, 1),
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ),
                            hintText: 'Enter Your Password',
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color.fromRGBO(8, 17, 40, 1),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 229, 229, 1),
                              Color.fromRGBO(233, 97, 255, 1)
                            ], // Adjust colors as desired
                          ),
                        ),
                        width: 163,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.all(8),
                            elevation: 4,
                            shadowColor: Colors.black,
                            backgroundColor: Colors
                                .transparent, // Set the background color to transparent
                          ),
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        '-Or Sign in with Google-',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(8, 17, 40, 1),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            top: 10,
                            bottom: 10,
                            right: 10,
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor: Color.fromRGBO(8, 17, 40, 1),
                              backgroundImage:
                                  AssetImage('assets/images/Google.png'),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 13),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignUpPage()));
                        },
                        child: const Text(
                          'Don’t have an account ? Signup',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
