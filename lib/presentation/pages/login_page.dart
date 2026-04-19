import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/core/widgets/divider.dart';

// ------------- //
// Widgets imports //
// ------------- //
import 'package:tourism_app/core/widgets/input_field.dart';
import 'package:tourism_app/core/widgets/submit_button.dart';

// ------------- //
// Screens imports //
// ------------- //
import 'package:tourism_app/presentation/pages/signup_page.dart';
import 'package:tourism_app/providers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isLoading = false;

  void submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).login(credentials: {'email': _email, 'password': _password});

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFFFF8F2),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Aleppo2.jpg', fit: BoxFit.cover),
          ),

          Positioned(
            child: Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  bottom: 16.0,
                  left: 16.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: const Offset(10, 27),
                                child: Text(
                                  "اكتشف مديــنة حــلب مـــع",
                                  style: TextStyle(
                                    color: const Color.fromRGBO(
                                      255,
                                      255,
                                      255,
                                      0.5,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "دَلــــــــــيلُك",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "سجل دخول في حسابك",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 15),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    inputField(
                                      placeholder: "البريد الالكتروني",
                                      icon: Icons.alternate_email,
                                      isObscure: false,
                                      shouldSave: true,
                                      onSaved: (value) {
                                        _email = value;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    inputField(
                                      placeholder: "كلمة المرور",
                                      icon: Icons.key,
                                      isObscure: true,
                                      shouldSave: true,
                                      onSaved: (value) {
                                        _password = value;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    submitButton(
                                      title: "سجل دخول",
                                      backgroundColor: const Color.fromRGBO(
                                        0,
                                        0,
                                        0,
                                        0.129,
                                      ),
                                      onPressed: () {
                                        _formKey.currentState?.save();

                                        submit();
                                      },
                                      isLoading: _isLoading,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              divider(
                                color: const Color.fromRGBO(255, 255, 255, 0.2),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "لا تملك حساب؟",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 7),
                                  InkWell(
                                    onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupPage(),
                                      ),
                                    ),
                                    child: Text(
                                      "أنشئ حساباً",
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
