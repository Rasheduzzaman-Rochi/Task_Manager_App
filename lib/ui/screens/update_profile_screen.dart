import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/theme_appBar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({
    super.key,
  });

  static const String name = "/update_profile";

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
      appBar: TMAppBar(
        fromUpdateProfile: true,
      ),
      body: background(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formState,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 32,
              ),
              Text('Update Profile', style: textTheme.titleLarge),
              SizedBox(height: 18),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 56,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[300],
                      ),
                      alignment: Alignment.center,
                      child: Text('Photo'),
                    ),
                    SizedBox(width: 8),
                    Text('No item selected')
                  ],
                ),
              ),
              SizedBox(height: 8),
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
            ]),
          ),
        ),
      )),
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
