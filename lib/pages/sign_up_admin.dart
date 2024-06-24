import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './log_in_admin.dart';
import './home_katalog_admin.dart'; 

class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin({super.key});

  @override
  _SignUpAdminState createState() => _SignUpAdminState();
}

class _SignUpAdminState extends State<SignUpAdmin> {
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordMatch = true;
  String _message = '';

  Future<void> _signUp() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        setState(() {
          _message = 'Registration Successful';
        });
        // Navigate to the HomeScreen or show a success message
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeKatalogAdmin()),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            _message = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            _message = 'The account already exists for that email.';
          } else {
            _message = 'Error: ${e.message}';
          }
        });
      } catch (e) {
        setState(() {
          _message = 'An unexpected error occurred.';
        });
      }
    } else {
      setState(() {
        _isPasswordMatch = false;
        _message = 'Password and Confirm Password must match';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(210, 226, 129, 10),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(29, 0, 29, 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 206.7,
                            child: Text(
                              'JASTRA',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                height: 0.7,
                                color: const Color(0xFF000000),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(29, 30, 29, 136),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 28),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                  height: 1.2,
                                  color: const Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFA8A8A9)),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF3F3F3),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                  height: 24,
                                  child: Icon(Icons.email),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 4),
                                    height: 40,
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your email',
                                        hintStyle: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(210, 226, 129, 10),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFA8A8A9)),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF3F3F3),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                  height: 24,
                                  child: Icon(Icons.lock),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 4),
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _isObscurePassword,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Color.fromARGB(210, 226, 129, 10),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isObscurePassword = !_isObscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    _isObscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFA8A8A9)),
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFF3F3F3),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                  height: 24,
                                  child: Icon(Icons.lock),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 4),
                                    child: TextField(
                                      controller: _confirmPasswordController,
                                      obscureText: _isObscureConfirmPassword,
                                      decoration: const InputDecoration(
                                        hintText: 'Confirm Password',
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: Color.fromARGB(210, 226, 129, 10),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isObscureConfirmPassword = !_isObscureConfirmPassword;
                                    });
                                  },
                                  child: Icon(
                                    _isObscureConfirmPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          if (!_isPasswordMatch)
                            Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Passwords do not match',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(top: 5, bottom: 20),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'By clicking the ',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: const Color(0xFF676767),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Register',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        height: 1.3,
                                        color: Color.fromARGB(210, 226, 129, 10),
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' button, you agree to the public offer',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: const Color(0xFF676767),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(210, 226, 129, 10),
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onPressed: _signUp,
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          // Display the message (success or error)
                          if (_message.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                _message,
                                style: TextStyle(
                                  color: _message == 'Registration Successful' ? Colors.green : Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.only(top: 40),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '- OR Continue with -',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: const Color(0xFF575757),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: 185,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xFFDCC8E9),
                                            ),
                                            borderRadius: BorderRadius.circular(50),
                                            color: const Color(0xFFFCF3F6),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Handle action when Google sign-in button is pressed
                                            },
                                            child: Container(
                                              width: 54,
                                              height: 54,
                                              padding: const EdgeInsets.all(14),
                                              child: Image.network(
                                                'https://drive.google.com/uc?id=19_NknzR-06OWa9Qp_f3JRsf9BIatCqeK',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already Have an Account',
                                    style: GoogleFonts.getFont(
                                      'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: const Color(0xFF575757),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LogInAdmin(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(5.8, 0, 0, 4),
                                      child: Text(
                                        'Login Here',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          decoration: TextDecoration.underline,
                                          color: const Color.fromARGB(210, 226, 129, 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
