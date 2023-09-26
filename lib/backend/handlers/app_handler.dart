import 'package:flutter/material.dart';

import 'package:mindwaves/frontend/config/palette.dart';
import 'package:mindwaves/frontend/routes/dashboard/dashboard.dart';

class Mindwaves extends StatelessWidget {
  const Mindwaves({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Dashboard(),
    );
  }
}
