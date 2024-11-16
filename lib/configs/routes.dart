import 'package:get/get.dart';
import 'package:study_track/views/screens/calender.dart';
import 'package:study_track/views/screens/dashboard_screen.dart';
import 'package:study_track/views/screens/home.dart';
import 'package:study_track/views/screens/login_screen.dart';
import 'package:study_track/views/screens/profile.dart';
import 'package:study_track/views/screens/register_screen.dart';
import 'package:study_track/views/screens/settings.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () =>  Login()),
  GetPage(name: '/register', page: () =>  RegisterScreen()),
  GetPage(name: '/dashboard', page: () => const DashboardScreen()),
  GetPage(name: '/home', page: () => const Home()),
  GetPage(name: '/settings', page: () => const SettingsScreen()),
  GetPage(name: '/calender', page: () => const CalenderScreen()),
  GetPage(name: '/profile', page: () => const Profile())

];