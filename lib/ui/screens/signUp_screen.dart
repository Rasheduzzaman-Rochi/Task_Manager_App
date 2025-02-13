import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

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
  bool _signUpInProgress = false;

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
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (String? value) {
                    if (_emailEditingController.text.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!_emailEditingController.text.contains('@')) {
                      return 'Invalid email format';
                    }
                    return null;
                  }),
              SizedBox(height: 8),
              TextFormField(
                  controller: _firstNameEditingController,
                  decoration: InputDecoration(
                    hintText: 'First name',
                  ),
                  validator: (String? value) {
                    if (_firstNameEditingController.text.trim().isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  }),
              SizedBox(height: 8),
              TextFormField(
                  controller: _lastNameEditingController,
                  decoration: InputDecoration(
                    hintText: 'Last name',
                  ),
                  validator: (String? value) {
                    if (_lastNameEditingController.text.trim().isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  }),
              SizedBox(height: 8),
              TextFormField(
                  controller: _mobileEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Mobile number',
                  ),
                  validator: (String? value) {
                    if (_mobileEditingController.text.trim().isEmpty) {
                      return 'Mobile number is required';
                    }
                    return null;
                  }),
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
                visible: _signUpInProgress == false,
                replacement: CenterCircularProgressIndicator(),
                child: ElevatedButton(
                    onPressed: _onTapSignUpButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                    )),
              ),
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

  void _onTapSignUpButton() {
    if (_formState.currentState!.validate()) {
      _registerUser();
    }
  }

  Future<void> _registerUser() async {
    _signUpInProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "email": _emailEditingController.text.trim(),
      "firstName": _firstNameEditingController.text.trim(),
      "lastName": _lastNameEditingController.text.trim(),
      "mobile": _mobileEditingController.text.trim(),
      "password": _passwordEditingController.text.trim(),
      "photo": ""
    };

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);
    setState(() {});
    _signUpInProgress = false;
    if (response.isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New user registration successful!');
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  void _clearTextFields() {
    _emailEditingController.clear();
    _firstNameEditingController.clear();
    _lastNameEditingController.clear();
    _mobileEditingController.clear();
    _passwordEditingController.clear();
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
