import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassAdmin extends StatefulWidget {
  const ForgotPassAdmin({super.key});

  @override
  _ForgotPassAdminState createState() => _ForgotPassAdminState();
}

class _ForgotPassAdminState extends State<ForgotPassAdmin> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD38609),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD38609),
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/vectors/vector_2_x2.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFD38609),
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(32.5, 0, 32.5, 35),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: 207.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'JASTRA',
                          style: GoogleFonts.getFont(
                            'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                            height: 1.5,
                            color: const Color(0xFF000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(29, 30, 29, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 21),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 28),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Forgot Pass',
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
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFA8A8A9)),
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFF3F3F3),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(11, 16, 11, 19),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0.3),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/images/user_2.png',
                                              ),
                                            ),
                                          ),
                                          child: const SizedBox(
                                            width: 20,
                                            height: 19.7,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            hintText: 'Email',
                                            border: InputBorder.none,
                                            hintStyle: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: const Color(0xFFD38609),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final email = _emailController.text;
                                  if (email.isNotEmpty) {
                                    try {
                                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Password reset email sent')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Failed to send email: $e')),
                                      );
                                    }
                                  }
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD38609),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Container(
                                      width: 96,
                                      padding: const EdgeInsets.fromLTRB(0, 15.5, 0.5, 15.5),
                                      child: Text(
                                        'Send',
                                        style: GoogleFonts.getFont(
                                          'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: const Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                child: Text(
                                  'Don’t Have an Account?',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: const Color(0xFF575757),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/signup');
                                },
                                child: Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 4),
                                  child: Text(
                                    'Sign Up Here',
                                    style: GoogleFonts.getFont(
                                      'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      color: const Color(0xFFD38609),
                                      decorationColor: const Color(0xFFD38609),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
