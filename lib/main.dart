import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:notflix/custom/bottom_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Async işlemler için gerekli
  await dotenv.load(); // Kök dizindeki .env dosyasını yükle
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notflix',
      home: const BottomBar(),
    );
  }
}
