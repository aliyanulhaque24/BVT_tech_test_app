import 'package:bvt_tech/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const BVTTech());
}

class BVTTech extends StatelessWidget {
  const BVTTech({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // for mobile screen responsiveness
      designSize: Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: // brief Theme of the app, works for testing but can be more detailed to match desired UI
              ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: Color.fromARGB(255, 234, 234, 234),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromARGB(255, 3, 196, 103),
                  iconTheme: IconThemeData(
                    color: Color.fromARGB(255, 234, 234, 234),
                  ),
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 234, 234, 234),
                  ),
                ),
              ).copyWith(
                // route transitions
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  },
                ),
              ),
          home: HomePage(), // this is the main start up page of the app
        );
      },
    );
  }
}
