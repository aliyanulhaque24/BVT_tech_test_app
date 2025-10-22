import 'package:bvt_tech/components/scaling_button.dart';
import 'package:bvt_tech/pages/match_schedule_card.dart';
import 'package:bvt_tech/pages/simple_leaderboard_display.dart';
import 'package:bvt_tech/pages/strike_rate_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            // spacing: 20.h,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Welcome to XYZ App',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 38, 38, 38),
                ),
              ),
              SizedBox(height: 20.h),
              buildButton(
                'Strike Rate Calculator',
                80,
                Color.fromARGB(255, 3, 196, 103),
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StrikeRateCalculator(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              buildButton(
                'Simple Leaderboard Display',
                80,
                Color.fromARGB(255, 3, 196, 103),
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SimpleLeaderboardDisplay(),
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              buildButton(
                'Match Schedule Card',
                80,
                Color.fromARGB(255, 3, 196, 103),
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MatchScheduleCard(),
                    ),
                  );
                },
              ),
              Spacer(),
              Text(
                'Test app by Aliyan Ul Haque',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Color.fromARGB(255, 71, 71, 71),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String text, int height, Color color, VoidCallback onTap) {
    return ScalingButton(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 234, 234, 234),
            ),
          ),
        ),
      ),
    );
  }
}
