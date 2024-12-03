import 'package:get/get.dart';
import 'package:study_track/views/screens/dashboard_screen.dart';
import 'package:study_track/views/screens/books.dart';
import 'package:study_track/views/screens/history.dart';
import 'package:study_track/views/screens/login_screen.dart';
import 'package:study_track/views/screens/profile.dart';
import 'package:study_track/views/screens/register_screen.dart';
import 'package:study_track/views/screens/settings.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () =>  Login()),
  GetPage(name: '/register', page: () =>  RegisterScreen()),
  GetPage(name: '/dashboard', page: () => const DashboardScreen()),
  GetPage(name: '/books', page: () => Book()),
  GetPage(name: '/settings', page: () => const SettingsScreen()),
  GetPage(name: '/profile', page: () => const Profile()),
  GetPage(name: '/history', page: () => History())

];