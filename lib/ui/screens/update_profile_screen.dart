import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/widgets/background_app.dart';
import 'package:task_manager_app/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';
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
  XFile? _pickedImage;

  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailEditingController.text = AuthController.userModel?.email ?? '';
    _firstNameEditingController.text =
        AuthController.userModel?.firstName ?? '';
    _lastNameEditingController.text = AuthController.userModel?.lastName ?? '';
    _mobileEditingController.text = AuthController.userModel?.mobile ?? '';
  }

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
                  enabled: false,
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
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _lastNameEditingController,
                decoration: InputDecoration(
                  hintText: 'Last name',
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Last name is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _mobileEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Mobile',
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Phone number is required';
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
              ),
              SizedBox(height: 18),
              Visibility(
                visible: _updateProfileInProgress = false,
                replacement: CenterCircularProgressIndicator(),
                child: ElevatedButton(
                    onPressed: _onTapUpdateButton,
                    child: Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.white,
                    )),
              ),
              SizedBox(height: 24),
            ]),
          ),
        ),
      )),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              alignment: Alignment.center,
              child: const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              _pickedImage == null ? 'No item selected' : _pickedImage!.name,
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery);
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  void _onTapUpdateButton() {
    if (_formState.currentState!.validate()) {
      _updateProfile();
    }
  }

  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": _emailEditingController.text.trim(),
      "firstName": _firstNameEditingController.text.trim(),
      "lastName": _lastNameEditingController.text.trim(),
      "mobile": _mobileEditingController.text.trim(),
    };

    if (_pickedImage != null) {
      List<int> imageBytes = await _pickedImage!.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }
    if (_passwordEditingController.text.isEmpty) {
      requestBody['password'] = _passwordEditingController.text;
    }

    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfile, body: requestBody);
    _updateProfileInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      _passwordEditingController.clear();
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
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
