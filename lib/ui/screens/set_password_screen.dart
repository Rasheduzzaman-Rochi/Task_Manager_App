import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  static const String name = '/setPassword';

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _ConfirmPasswordEditingController =
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
              Text('Set Password', style: textTheme.titleLarge),
              SizedBox(height: 14),
              Text(
                  "Minimum length password 8 character with \nLatter and number combination",
                  style: textTheme.titleSmall),
              SizedBox(height: 16),
              TextFormField(
                  controller: _passwordEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  )),
              SizedBox(height: 8),
              TextFormField(
                controller: _ConfirmPasswordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 18),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: 45),
              Center(child: _buildSignUpSection()),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _buildSignUpSection() {
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
                Navigator.pushNamedAndRemoveUntil(
                    context, SigninScreen.name, (value) => false);
              },
          ), // Added closing parenthesis for TextSpan
        ],
      ),
    );
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _ConfirmPasswordEditingController.dispose();
    super.dispose();
  }
}
