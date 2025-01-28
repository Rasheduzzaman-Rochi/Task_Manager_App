import 'package:flutter/material.dart';
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
                    "Rabbil Hasan",
                    style: textTheme.titleSmall?.copyWith(color: Colors.white),
                  ),
                  Text(
                    "rabbill@gmail.com",
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          IconButton(icon: Icon(Icons.logout), onPressed: () {})
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
