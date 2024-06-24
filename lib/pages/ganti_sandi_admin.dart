import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GantiSandiAdmin extends StatefulWidget {
  const GantiSandiAdmin({super.key});

  @override
  _GantiSandiAdminState createState() => _GantiSandiAdminState();
}

class _GantiSandiAdminState extends State<GantiSandiAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;
        String email = _emailController.text.trim();
        String oldPassword = _oldPasswordController.text.trim();
        String newPassword = _newPasswordController.text.trim();

        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: oldPassword);
        await user?.reauthenticateWithCredential(credential);

        // Update password
        await user?.updatePassword(newPassword);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password updated successfully')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 15.5, 0, 15.5),
                          width: 6,
                          height: 12,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              'assets/vectors/vector_10_x2.svg',
                            ),
                          ),
                        ),
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 69),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(29, 0, 29, 17),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Change Password',
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
                          margin: const EdgeInsets.fromLTRB(29, 0, 29, 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 278.9,
                              child: Text(
                                'Send me your email to change your password!',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11,
                                  color: const Color(0xFF575757),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(29, 0, 29, 13),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email, color: const Color(0xFFD38609)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: const Color(0xFFA8A8A9)),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F3F3),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(29, 0, 29, 17),
                          child: TextFormField(
                            controller: _oldPasswordController,
                            decoration: InputDecoration(
                              labelText: 'Old Password',
                              prefixIcon: Icon(Icons.lock, color: const Color(0xFFD38609)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: const Color(0xFFA8A8A9)),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F3F3),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your old password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(29, 0, 29, 23),
                          child: TextFormField(
                            controller: _newPasswordController,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              prefixIcon: Icon(Icons.lock_open, color: const Color(0xFFD38609)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: const Color(0xFFA8A8A9)),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F3F3),
                            ),
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your new password';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton(
                              onPressed: _changePassword,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD38609),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.5),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
