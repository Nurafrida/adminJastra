import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './sign_up_admin.dart';
import './home_katalog_admin.dart';
import './forgot_pass_admin.dart';

class LogInAdmin extends StatefulWidget {
  const LogInAdmin({super.key});

  @override
  _LogInAdminState createState() => _LogInAdminState();
}

class _LogInAdminState extends State<LogInAdmin> {
  bool _isObscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _message = '';

  Future<void> _signInWithEmailPassword() async {
    setState(() {
      _message = '';
    });
    try {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeKatalogAdmin()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message ?? 'An unknown error occurred';
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _message = '';
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _auth.signInWithCredential(credential);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeKatalogAdmin()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _message = e.message ?? 'An unknown error occurred';
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
                                'LOGIN',
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
                                SizedBox(
                                  width: 30,
                                  height: 24,
                                  child: Image.network(
                                    'https://drive.google.com/uc?id=1emc7zn-9W4ZDcsv7BHhF89On8kZt7rbX',
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.fromLTRB(10, 5, 0, 4),
                                    height: 40,
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter your username or email',
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
                                SizedBox(
                                  width: 30,
                                  height: 24,
                                  child: Image.network(
                                    'https://drive.google.com/uc?id=1HNYOhB0d5T3xQdUEH3N7CZ4eTC5r4mfV',
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const Icon(Icons.error);
                                    },
                                  ),
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
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                          // Login Button
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(210, 226, 129, 10), // Button color
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24), // Padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4), // Square corners
                                ),
                              ),
                              onPressed: _signInWithEmailPassword,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          if (_message.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Text(
                                _message,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(1, 0, 1, 38),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgotPassAdmin()),
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Forgot Password',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      height: 1.3,
                                      color: const Color.fromARGB(210, 226, 129, 10),
                                    ),
                                  ),
                                ),
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
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: 185,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFFDCC8E9)),
                                            borderRadius: BorderRadius.circular(50),
                                            color: const Color(0xFFFCF3F6),
                                          ),
                                          child: GestureDetector(
                                            onTap: _signInWithGoogle,
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
                                          builder: (context) => const SignUpAdmin(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(5.8, 0, 0, 4),
                                      child: Text(
                                        'Sign Up here',
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
