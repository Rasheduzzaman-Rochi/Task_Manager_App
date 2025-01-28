import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/forgot_password_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_Screen.dart';
import 'package:task_manager_app/ui/screens/signUp_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static const String name = '/signin';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: background(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formState,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 80,
              ),
              Text('Get Started With', style: textTheme.titleLarge),
              SizedBox(height: 18),
              TextFormField(
                  controller: _emailEditingController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MainBottomNavScreen.name);
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  )),
              SizedBox(height: 45),
              Center(
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPasswordScreen.name);
                        },
                        child: Text('Forgot Password?')),
                    _buildSignUpSection(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        text: "Don't have account? ",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: 'Sign Up',
            style: TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, SignUpScreen.name);
              },
          ), // Added closing parenthesis for TextSpan
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }
}
