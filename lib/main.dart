import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hot_store1/screens/bottom_navigation_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ECommerce APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red.shade900, background: Colors.grey.shade200),
        useMaterial3: true,
      ),
      home: const BottomNavScreen(),
    );
  }
}
