import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ------------- //
// Widgets imports //
// ------------- //
import 'package:tourism_app/core/widgets/divider.dart';
import 'package:tourism_app/core/widgets/input_field.dart';
import 'package:tourism_app/core/widgets/submit_button.dart';

// ------------- //
// Screens imports //
// ------------- //
import 'package:tourism_app/presentation/pages/login_page.dart';
import 'package:tourism_app/providers/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  late String _username, _email, _password;
  bool _isLoading = false;

  void submit() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).signUp(
        credentials: {
          'name': _username,
          'email': _email,
          'password': _password,
        },
      );
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
    // Auth authProvider = Provider.of<Auth>(context);
    // final user = authProvider.user;

    return Scaffold(
      backgroundColor: Color(0xFFFFF8F2),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/Aleppo.jpg', fit: BoxFit.cover),
          ),

          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.1),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 7),
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
                                "أنشئ حساباً جديداً",
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
                                      title: "أنشئ حساباً",
                                      backgroundColor: Color.fromRGBO(
                                        0,
                                        0,
                                        0,
                                        0.129,
                                      ),
                                      onPressed: () {
                                        _formKey.currentState?.save();

                                        _username =
                                            "User #${Random().nextInt(777) + 1}";

                                        submit();
                                      },
                                      
                                      isLoading: _isLoading,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 15),

                              divider(
                                color: const Color.fromRGBO(
                                  255,
                                  255,
                                  255,
                                  0.25,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "تملك حساب؟",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 7),
                                  InkWell(
                                    onTap: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    ),
                                    child: Text(
                                      "سجل دخول",
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
