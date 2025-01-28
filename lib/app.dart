import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_otp_screen.dart';
import 'package:task_manager_app/ui/screens/forgot_password_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_Screen.dart';
import 'package:task_manager_app/ui/screens/set_password_screen.dart';
import 'package:task_manager_app/ui/screens/signIn_screen.dart';
import 'package:task_manager_app/ui/screens/signUp_screen.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';
import 'package:task_manager_app/ui/utils/app_colors.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(
              titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              titleSmall: TextStyle(
                color: Colors.grey[700],
              )),
          colorSchemeSeed: AppColors.themeColor,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              hintStyle:
                  TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              fillColor: Colors.white,
              border: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  fixedSize: Size.fromWidth(double.maxFinite),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16)))),
      initialRoute: SplashScreen.name,
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = SplashScreen();
        } else if (settings.name == SigninScreen.name) {
          widget = SigninScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = SignUpScreen();
        } else if (settings.name == ForgotPasswordScreen.name) {
          widget = ForgotPasswordScreen();
        } else if (settings.name == ForgotPasswordOtpScreen.name) {
          widget = ForgotPasswordOtpScreen();
        } else if (settings.name == SetPasswordScreen.name) {
          widget = SetPasswordScreen();
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = MainBottomNavScreen();
        } else if (settings.name == AddNewTaskScreen.name) {
          widget = AddNewTaskScreen();
        }else if (settings.name == UpdateProfileScreen.name) {
          widget = UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (_) => widget);
      },
    );
  }
}
