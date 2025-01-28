import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/Signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
  final TextEditingController _mobileEditingController =
      TextEditingController();
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
              Text('Join With Us', style: textTheme.titleLarge),
              SizedBox(height: 18),
              TextFormField(
                  controller: _emailEditingController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              SizedBox(height: 8),
              TextFormField(
                controller: _firstNameEditingController,
                decoration: InputDecoration(
                  hintText: 'First name',
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _lastNameEditingController,
                decoration: InputDecoration(
                  hintText: 'Last name',
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _mobileEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Mobile',
                ),
              ),
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
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  )),
              SizedBox(height: 24),
              Center(
                child: _buildSignInSection(),
              ),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        text: "Have account? ",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
        children: [
          TextSpan(
            text: 'Sign in',
            style: TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
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
    _firstNameEditingController.dispose();
    _lastNameEditingController.dispose();
    _mobileEditingController.dispose();
    super.dispose();
  }
}