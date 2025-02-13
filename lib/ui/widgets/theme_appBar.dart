import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/controllers/auth_controller.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.fromUpdateProfile = false,
  });

  final bool fromUpdateProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColors.themeColor,
      title: Row(
        children: [
          CircleAvatar(),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!fromUpdateProfile) {
                  Navigator.pushNamed(context, UpdateProfileScreen.name);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userModel?.fullName ?? '',
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  Text(
                    AuthController.userModel?.email ?? '',
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushNamedAndRemoveUntil(
                    context, SigninScreen.name, (predicate) => false);
              })
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}