import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String name = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailEditingController = TextEditingController();

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
              Text('Your Email Address', style: textTheme.titleLarge),
              SizedBox(height: 14),
              Text(
                  "A 6 digit verification pin will send to your \nemail address",
                  style: textTheme.titleSmall),
              SizedBox(height: 14),
              TextFormField(
                  controller: _emailEditingController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  )),
              SizedBox(height: 14),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ForgotPasswordOtpScreen.name);
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                  )),
              SizedBox(height: 24),
              Center(
                child: _ForgotPasswordScreen(),
              ),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _ForgotPasswordScreen() {
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
    super.dispose();
  }
}
