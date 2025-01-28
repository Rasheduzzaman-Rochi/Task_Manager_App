import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/ui/screens/set_password_screen.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';

class ForgotPasswordOtpScreen extends StatefulWidget {
  const ForgotPasswordOtpScreen({super.key});

  static const String name = '/forgot-password-otp';

  @override
  State<ForgotPasswordOtpScreen> createState() =>
      _ForgotPasswordOtpScreenState();
}

class _ForgotPasswordOtpScreenState extends State<ForgotPasswordOtpScreen> {
  final TextEditingController _OtpController = TextEditingController();

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
              Text('PIN Verification', style: textTheme.titleLarge),
              SizedBox(height: 12),
              Text(
                "A 6 digit verification pin will send to your \nemail address",
                style: textTheme.titleSmall,
              ),
              SizedBox(height: 16),
              _buildPinCodeTextField(),
              SizedBox(height: 14),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SetPasswordScreen.name);
                  },
                  child: Text(
                    "Verify",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
              SizedBox(height: 24),
              Center(
                child: _ForgotPasswordOtpScreen(),
              ),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 45,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _OtpController,
      appContext: context,
    );
  }

  Widget _ForgotPasswordOtpScreen() {
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
    _OtpController.dispose();
    super.dispose();
  }
}
