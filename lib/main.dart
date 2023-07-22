import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_watch/app/app_widget.dart';
import 'package:go_watch/app/constants/style.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ),
  );
  await dotenv.load(fileName: ".env");
  runApp(const AppWidget());
}
