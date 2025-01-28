import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/ui/utils/assets_path.dart';

class background extends StatelessWidget {
  const background({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          height: double.maxFinite,
          width: double.maxFinite,
          AssetsPath.backgroundSvg,
          fit: BoxFit.fill,
        ),
        SafeArea(child: child),
      ],
    );
  }
}