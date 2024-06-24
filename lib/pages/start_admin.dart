import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './log_in_admin.dart';
import './sign_up_admin.dart';

class StartAdmin extends StatelessWidget {
  const StartAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
              ),
              padding: const EdgeInsets.fromLTRB(29, 195, 26, 275),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://drive.google.com/uc?id=1uaufhX5ePKLOevVGuT_5Hk0hCWllPCPE',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 300,
                      height: 300,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SignUpAdmin()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(210, 226, 129, 10),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LogInAdmin()),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(210, 226, 129, 10)),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white10,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  'Log In',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: const Color.fromARGB(210, 226, 129, 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
