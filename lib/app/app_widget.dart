import 'package:flutter/material.dart';
import 'package:go_watch/app/routes/tab_bar.dart';
import 'package:skeletons/skeletons.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 255, 255, 255),
          Color.fromARGB(255, 212, 212, 212),
          Color.fromARGB(255, 146, 146, 146),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient: LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
      child: MaterialApp(
        home: MyTabBar(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
