import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/forgot_password_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_Screen.dart';
import 'package:task_manager_app/ui/screens/signUp_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

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
  bool _signInProgress = false;

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
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _passwordEditingController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your password';
                  }
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(height: 18),
              Visibility(
                visible: _signInProgress == false,
                replacement: CenterCircularProgressIndicator(),
                child: ElevatedButton(
                    onPressed: _onTapSigninScreen,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                    )),
              ),
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

  void _onTapSigninScreen() {
    if (_formState.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailEditingController.text.trim(),
      "password": _passwordEditingController.text,
    };
    final NetworkResponse response =
        await NetworkCaller.postRequest(url: Urls.loginUrl, body: requestBody);
    _signInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      String token = response.responseData!['token'];
      UserModel userModel = UserModel.fromJson(response.responseData!['data']);
      await AuthController.saveUserData(token, userModel);
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
    } else {
      _signInProgress = false;
      setState(() {});
      if (response.statusCode == 401) {
        showSnackBarMessage(context, 'Email/Password is invalid! Try again');
      } else {
        showSnackBarMessage(context, response.errorMessage);
      }
    }
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