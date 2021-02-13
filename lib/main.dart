import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpapers_30/home_page.dart';
import 'package:wallpapers_30/pixabay_api.dart';
import 'package:wallpapers_30/walpaper_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WalpaperState(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
