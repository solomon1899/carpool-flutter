import 'package:carpool_app/services/firebase_service.dart';
import 'package:carpool_app/services/map_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:carpool_app/screens/drive_screen.dart';
import 'package:provider/provider.dart';
import 'screens/base_screen.dart';
import 'firebase_options.dart';
import 'package:carpool_app/screens/launch_screen_options.dart';
import 'package:carpool_app/screens/auth_screen.dart';
import 'screens/launch_screen.dart' as launchScreen;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapScreenProvider(),
          child: MyApp(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/drive': (context) => DriveScreen(),
        '/launchscreenoptions': (context) => LaunchScreenOptions(),
        '/': (context) => StreamProvider.value(
              initialData: null,
              value: FirebaseService().user,
              child: launchScreen.LaunchScreen(),
            ),
        '/auth': (context) => AuthScreen("None"),
        '/home': (context) => BaseScreen(),
      },
    );
  }
}
