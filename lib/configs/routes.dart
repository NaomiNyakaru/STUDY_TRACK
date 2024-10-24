import 'package:get/get.dart';
import 'package:study_track/views/screens/dashboard_screen.dart';
import 'package:study_track/views/screens/login_screen.dart';
import 'package:study_track/views/screens/register_screen.dart';

List <GetPage> routes = [
  GetPage(name: '/', page: () => Login()),
  GetPage(name: '/register', page: () => RegisterScreen()),
  GetPage(name: '/dashboard', page: () => Dashboard()),

];