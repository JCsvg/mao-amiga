import 'package:flutter/material.dart';
import '../../../app/screens/utils/ong_profile_screen.dart';
import '../../../app/screens/utils/volunteer_profile_screen.dart';
import '../../../app/theme_mode_app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.isOng,
    required this.themeControl,
  });
  final bool isOng;
  final ThemeModeApp themeControl;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return (widget.isOng)
        ? OngProfileScreen(
            themeControl: widget.themeControl,
            isOng: widget.isOng,
          )
        : VolunteerProfileScreen(themeControl: widget.themeControl);
  }
}
