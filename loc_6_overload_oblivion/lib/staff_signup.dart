import 'package:flutter/material.dart';
import 'package:loc_6_overload_oblivion/resources/auth_methods.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _staffIdController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _staffIdController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthMethods authMethods = AuthMethods();
    void signUp() async {
      if (_passwordController.text != _confirmpasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please fill all the fields"),
          ),
        );
      } else {
        String res = await authMethods.signUpUser(
          staffid: _staffIdController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (res != "Success") {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res)));
          print(res.toString());
        } else {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) => Scaffold()));
        }
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SIGN  UP',
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
                  height: 413,
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
                          controller: _emailController,
                          style: TextStyle(color: Colors.white),
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
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 281,
                        height: 48,
                        child: TextField(
                          controller: _staffIdController,
                          style: TextStyle(color: Colors.white),
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
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 281,
                        height: 48,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _confirmpasswordController,
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
                            labelText: 'Confirm Password',
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
                        decoration: BoxDecoration(
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
                          onPressed: signUp,
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
                          child: const Text('Sign Up'),
                        ),
                      ),
                      const SizedBox(height: 13),
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement signup redirection
                        },
                        child: const Text(
                          'Already have an account ? Login',
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
